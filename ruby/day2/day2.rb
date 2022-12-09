# Rock defeats Scissors
# Scissors defeats Paper
# Paper defeats Rock.

file = ARGV[0]
lines = File.readlines(file).each(&:strip!)

ROCK = 1
PAPER = 2
SCISSORS = 3

LOST = 0
DRAW = 3
WIN = 6

CODE = {
  "A" => ROCK, "B" => PAPER, "C" => SCISSORS,
  "X" => ROCK, "Y" => PAPER, "Z" => SCISSORS,
}

CODE2 = {
  "A" => ROCK, "B" => PAPER, "C" => SCISSORS,
  "X" => LOST, "Y" => DRAW, "Z" => WIN,
}

PICK = {
  ROCK => { LOST => SCISSORS, DRAW => ROCK, WIN => PAPER },
  PAPER => { LOST => ROCK, DRAW => PAPER, WIN => SCISSORS },
  SCISSORS => { LOST => PAPER, DRAW => SCISSORS, WIN => ROCK },
}

def round2(lines)
  puts lines.inject(0) { |sum, line|
    them, score = line.split(' ').map { |x| CODE2[x] }
    sum + score + PICK[them][score]
  }
end

round2(lines)

def get_score_1(them, me)
  return [DRAW,DRAW] if them == me
#  return [LOST,WIN] if (them == ROCK && me == SCISSORS) || (me - them == 1)
  if (them == SCISSORS && me == ROCK) ||
      (them == ROCK && me == PAPER) ||
      (them == PAPER && me == SCISSORS)
    return [LOST,WIN]
  end
  [WIN,LOST]
end

def round1(lines)
  puts lines.inject(0) { |sum, line|
    them, me = line.split(' ').map { |x| CODE[x] }
    their_score, my_score = get_score_1(them, me)
    sum + me + my_score
  }
end

