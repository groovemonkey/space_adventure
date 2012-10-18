# code tools by dave

def rand_range(min, max)
  min + rand(max - min)
end


def rare?()
  rand(300) == 42
end

def get_input()
    print("\n\nWhat Now?\n" + "> ")
    playerinput = gets.chomp!.downcase().split() #returns ["input", "split", "on", "spaces"]
  end