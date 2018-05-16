require "rails_helper"

RSpec.describe Invitation do


  def update_team_owner(owner, team)
    team.update!(owner: owner)
    owner.update!(team: team)
  end

  def build_invitation(user, team)    
    build(:invitation, team: team, user: user)    
  end

  def create_user(email)    
    create(:user, email: email)    
  end

  def create_team(name)    
    create(:team, name: name)    
  end

  def create_team_owner    
    create(:user)    
  end

  describe "callbacks" do
    describe "after_save" do
      context "with valid data" do
        it "invites the user" do
          user = create_user("rookie@example.com")
          team = create_team("A fine team")
          invitation = build_invitation(user, team)
          invitation.save
          expect(user).to be_invited
        end
      end

      context "with invalid data" do    
        it "does not save the invitation" do
          user = create_user("rookie@example.com")
          team = create_team("A fine team")
          invitation = build_invitation(user, nil)
          expect(invitation).not_to be_valid
          expect(invitation).to be_new_record
        end

        it "does not mark the user as invited" do
          user = create_user("rookie@example.com")
          expect(user).not_to be_invited
        end
      end
    end
  end

 describe "#event_log_statement" do
    context "when the record is saved" do

      it "include the name of the team" do
        user = create_user("rookie@example.com")
        team = create_team("A fine team")
        invitation = build_invitation(user, team)
        invitation.save

        log_statement = invitation.event_log_statement
        expect(log_statement).to include("A fine team")
      end

      it "include the email of the invitee" do
        user = create_user("rookie@example.com")
        team = create_team("A fine team")
        invitation = build_invitation(user, team)
        invitation.save

        log_statement = invitation.event_log_statement
        expect(log_statement).to include("rookie@example.com")
      end
    end

    context "when the record is not saved but valid" do
      it "includes the name of the team" do
        user = create_user("rookie@example.com")
        team = create_team("A fine team")
        invitation = build_invitation(user, team)        

        log_statement = invitation.event_log_statement
        expect(log_statement).to include("A fine team")
      end

      it "includes the email of the invitee" do
        user = create_user("rookie@example.com")
        team = create_team("A fine team")
        invitation = build_invitation(user, team)

        log_statement = invitation.event_log_statement
        expect(log_statement).to include("rookie@example.com")
      end

      it "includes the word 'PENDING'" do
        user = create_user("rookie@example.com")
        team = create_team("A fine team")
        invitation = build_invitation(user, team)

        log_statement = invitation.event_log_statement
        expect(log_statement).to include("PENDING")
      end
    end

    context "when the record is not saved and not valid" do
      it "includes INVALID" do
        team = create_team("A fine team")
        invitation = build_invitation(nil, team)

        log_statement = invitation.event_log_statement
        expect(log_statement).to include("INVALID")
      end
    end
  end
end
