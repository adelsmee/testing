# So, long story short, this is just some fight mechanics that is to simulate
# a fight between the player and a wolf in the combat style of D&D.
# The layout is just a loop with 2 things happening:
# 1. The player rolling an armour check on the wolf and failing. The wolf then
# fights back.
# 2. The player rolling and armour check on the wolf and passing. The player then
# attacks the wolf and then providing the wolf is still alive, it will fight back.
#
# Currently there is no mechanic for the player to die.


p_health = 100
p_armour = 14
p_xp = 1


w_health = 30
w_shealth = 30
w_xp = 50
w_armour = 13
pa1 = [*1..20] #player armour check roll
da1 = [*1..20] #player damage check roll
wa1 = [*1..20] #wolf armour check roll
watk1 = [*1..20] #wolf damage check roll

prompt = "> "
puts "\nA vicious wolf leaps from seemingly nowhere!"
puts "\nWhat would you like to do? run, fight"
puts
print prompt

while user_input = gets.chomp # Fight loop until fight is over.
  case user_input
  when "fight" # fight or run? here we fight for glory!
    t = Time.now
    sleep(t + 1 - Time.now) #placed in timers as the console just prints things
                            # far to quickly for my liking.
    pa =  pa1[rand(pa1.length)] # Roll D20 for armour check
                                # This has to be inside the loop or won't pick
                                # a new random number each time.
      if
        pa < w_armour # If the Players D20 roll is higher than the wolf's armour
                      # then when the attack roll is done it will hit.
        # The below place holder text. End result will be something more immersive.
        puts "You roll an armour check of #{pa}. \nYour attack misses."
        puts
        if
          w_health >= 0 # After the player rolls and misses it's the wolf's turn.
                        # The wolf will only have a turn if it is alive...
          wa =  wa1[rand(wa1.length)] # Wolf rolls a D20
            if
              wa < p_armour # Is the wolfs D20 roll higher than players armour?
              t = Time.now # timer to simulate wolf having a turn.
              sleep(t + 1 - Time.now)
              # The below place holder text. End result will be something more immersive.
              puts "Wolf rolls an armour check of #{wa}. \nWolf's attack misses."
              puts
            elsif
              wa >= p_armour # This is where the wolf's D20 roll is higher than
                             # the player's armour. The wolf can now attack.
              t = Time.now # Another wait timer to show wolf's turn.
              sleep(t + 1 - Time.now)
              # The below place holder text. End result will be something more immersive.
              puts "Wolf rolls an armour check of #{wa}. \nThe wolf's next attack will hit. "
              puts
              t = Time.now
              sleep(t + 1 - Time.now)
              wat =  watk1[rand(watk1.length)] # Wollf rolls a D20 for an attack.
              puts "Wolf rolls an attack of #{wat}"
              p_health = p_health - wat # Variable to change the player's
                                        # total health after wolf hits them.
              puts "Your health has been reduced to #{p_health}"
              puts
            end
          end
          print prompt
        elsif
          w_health >= 0 # Is wolf alive?
          pa >= w_armour # Player's D20 roll now
          # place holder text
          puts "You roll an armour check of #{pa}. \nYour next attack will hit the wolf"
          puts
          t = Time.now
          sleep(t + 1 - Time.now)
          da =  da1[rand(da1.length)]
          # place holder text
          puts "You roll an attack of #{da}"
          w_health = w_health - da
          # place holder text
          puts "The wolf's health is reduced to #{w_health}."
          puts
          if
            w_health >= 1
            wa = wa1[rand(wa1.length)]
            if
              wa < p_armour
              t = Time.now
              sleep(t + 1 - Time.now)
              puts "Wolf rolls an armour check of #{wa}. \nThe wolf's next attack will miss"
              puts
              print prompt
            elsif
              wa >= p_armour
              t = Time.now
              sleep(t + 1 - Time.now)
              # place holder text
              puts "Wolf rolls an armour check of #{wa}. \nThe wolf's next attack will hit. "
              # place holder text
              t = Time.now
              sleep(t + 1 - Time.now)
              wat =  watk1[rand(watk1.length)]
              puts "Wolf rolls an attack of #{wat}"
              p_health = p_health - wat
              puts "Your health has been reduced to #{p_health}"
              puts
            end
          end
          if
            # Here the wolf dies and the player is rewarded by being given XP to
            # add towards leveling
            w_health <= 0
            # place holder text
            puts "Wolf dead!!"
            p_xp = w_xp + p_xp
            puts "You have gained #{w_xp}xp, your current xp level is #{p_xp}xp"
            puts
            break
          end
        end
      else
        puts "Invalid Selection" # Failsafe for if the user enters something
                                 # that is not recognised.
        print prompt
      end
    end
