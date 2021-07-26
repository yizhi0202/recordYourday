enum Myaudit { unknown, auditing, pass, reject }

/// the audit's state of paceNote

int voteThreshhold = 20;

SetVoteThreshhold(int value) {
  voteThreshhold = value;
}
