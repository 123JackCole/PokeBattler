require "tty-prompt"

class CommandLineInterface
    prompt = TTY::Prompt.new
    
    def welcome
        puts "Welcome to PokeBattler! Please enter your name."
        puts ""
        @name = gets.chomp
        @user = Trainer.create(name: @name)
        puts "Registered as trainer #{@name}"
        puts
    end

    def tutorial
        puts "Some things to remember:"
        puts "  1. You can only have one Pokemon at a time."
        puts "  2. An opponent will be randomly assigned to you for every battle."
        puts "  3. You will pick a new Pokemon after every battle."
        puts "  4. Don't forget to have fun!"
        puts "                                                                                      Hit enter to continue"
        gets.chomp
    end

    def get_pokemon
        prompt = TTY::Prompt.new
        puts "Let's see who your Pokemon will be!"
        puts
        array = ["Get Pokemon", "Exit"]
        input = prompt.select("Get Pokemon or Exit?", array)
        if input == "Get Pokemon"
            puts @user.pick_pokemon
            puts ""
        elsif input == "Exit"
            return exit
        end
        main_menu
    end

    def main_menu
        prompt = TTY::Prompt.new
        array = ["New Pokemon", "My Current Pokemon", "Battle", "Stats", "Exit"]
        input = prompt.select("What would you like to do?", array)
        if input == "New Pokemon"
            puts @user.pick_pokemon
            puts ""
            main_menu
        elsif input == "My Current Pokemon"
            name = @user.current_pokemon
            main_menu
            puts
        elsif input == "Battle"
            battle_title
            puts ""
            battle
            puts
        elsif input == "Stats"
            stats
            puts
        elsif input == "Exit"
            return exit
        end

    end

    def stats 
        prompt = TTY::Prompt.new
        choices = ["Wins", "Losses", "Win Rate", "Pokemon Used", "Trainers Battled", "Arch Rival", "Favorite Pokemon", "Not You Again", "Best Trainer", "Worst Trainer", "Best Pokemon", "Worst Pokemon", "Main Menu", "Exit"]
        input = prompt.select("Pick a stat to see.", choices)
        if input == "Main Menu"
            main_menu
        elsif input == "Wins"
            puts @user.wins
            puts
            stats
        elsif input == "Losses"
             puts @user.losses
             puts
             stats
        elsif input == "Win Rate"
            puts @user.win_rate
            puts
            stats
        elsif input == "Pokemon Used"
            puts @user.pokemon_used
            puts
            stats
        elsif input == "Trainers Battled"
            puts @user.trainers_battled
            puts
            stats
        elsif input == "Arch Rival"
            puts @user.arch_rival
            puts
            stats
        elsif input == "Favorite Pokemon"
            puts @user.fav_pokemon
            puts
            stats
        elsif input == "Not You Again"
            puts @user.not_you_again
            puts
            stats
        elsif input == "Best Trainer"
            Trainer.the_best
            puts
            stats
        elsif input == "Worst Trainer"
            Trainer.the_worst
            puts
            stats
        elsif input == "Best Pokemon"
            Pokemon.the_best
            puts
            stats
        elsif input == "Worst Pokemon"
            Pokemon.the_worst
            puts
            stats
        elsif input == "Exit"
           return exit
        end
    end

    def battle
        @user.battle!
        puts
        get_pokemon
    end

    def exit
        return "Thanks for using PokeBattler!"
    end

    def run
        splash_page
        tutorial
        welcome
        get_pokemon
    end

    def battle_title
        puts "+-+ +-+ +-+ +-+ +-+ +-+ +-+"
        puts "|B| |a| |t| |t| |l| |e| |!|"
        puts "+-+ +-+ +-+ +-+ +-+ +-+ +-+"
    end

    def splash_page
        puts ". . . . . ,. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ,. ."
        puts " . . . . . \`-, . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ,,-- ‘`/. ."
        puts " . . . . . . \:,,`-,. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ,---‘`’,,-,::/`. . ."
        puts " . . . . . . .\:\ •`’-,’’--,, . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ,,--‘`::,,--`••/`:/`. . . . ."
        puts " . . . . . . . `\"\••••`’’-,:`’--,. . . . . . . . . . . . . . . . . . . . . . . . . . . . .,,-`’:,,--‘`••••••,/:./ . . . . ."
        puts " . . . . . . . . .`\`-,••••••`’-,:`-,. . . . . .,_--‘- `’ --`’ -‘’`-‘--,_. . . . ..-‘`::,-`’ •••••••••••••/::/` . . . ." 
        puts " . . . . . . . . . . `-,`,••••••••`’-,`’-,.,,-`¯:::::::::::::::::::::: ::`’’-, ,,-`’::,-` •••••••••••••/::/`. . . . ."
        puts " . . . . . . . . . . . .`’-,`-,•••••••`\::`’::::::::::::::::::::::::::::::::::::`::.-` •••••••••••,-`’:,-`. . . . . ."
        puts " . . . . . . . . . . . . . . ` -,’’--••`\`:::,,,:::::::::::::::::,-----,::: :::`¯,-`••••,,--‘`:,,-`’ . . . . . ,,. . . ."
        puts " . . . . . . . . . . . . . . . . . ` ’’ -,-:/__/\:::::::::::::::/_,-`#\:::::: :`’`’’`’`::,,--‘` . . . . . . . /``\ . . . ."
        puts " . . . . . . . . . . . . . . . . . . . . |`:|###|:::::::::::::::|####`|:: :::::::-`’``. . . . . . . . . ,,-`····\ . . . ."
        puts " . . . . . . . . . . . . . . . . . . . . /’::\…/`:::,--,::::::::\,_,--‘`:::::::::|. . . . . . . . ,,,--` ···········\. . ."
        puts " . . . . . . . . . . . . . . . . . . . .(::::::::::,______,::::::::: ::::::::::/` . . .,,---‘’-············ ········\. ."
        puts " . . . . . . . . . . . . . . . . . . . . \::::::::::::::: ::::::::::::::::::::::::,/__,-`’`::::::`,/_···················\ ."
        puts " . . . . . . . . . . . . . . . . . .,,-`’·`’-,:::::::::::::::::::: :::::::::::,,-`’······-,---::::::::::/_ ·······,····,··| . ."
        puts " . . . . . . . . . . . . . . . . ,/`·········,-‘`’’---- - - - - - - - - ‘`\`··············`\,:::::::::::::|,,- ‘. .`-‘::::`’| . ."
        puts " . . . . . . . . . . . . . . . .’`|········/`··············· ··················\,···············\:::::::::::::::::::::::::/. ."
        puts " . . . . . . . . . . . . . . . . |·,·····(····/’ ································\······ ·······,\:::::: ::::::::::::::::/. ."
        puts " . . . . . . . . . . . . . . . . `\..···|,···(· ·|·······························/····· ·····/|/:::::::::::::::::::::::/`. . "
        puts " . . . . . . . . . . . . . . . . . `.`’ -\···\···|···························./`··· ·······/`::::::::::::::::::::: ::/ . ."
        puts " . . . . . . . . . . . . . . . . . . . . .|`\·\,··\ · ················,,,--`,-.,-, -`’-/,::: ::::::::::::::::::::/`. . ."
        puts " . . . . . . . . . . . . . . . . . . . . .|::::`’ --,\,· ····,-‘`\/`.`:::/:: `::::::::::|:::::::::::::::::::,-`’. . . "
        puts " . . . . . . . . . . . . . . . . . . . . . \::::::: ::::`-|/`::`::: ::/`::::::::::::::/::::::::::::::,,--‘` . ."
        puts " . . . . . . . . . . . . . . . . . . . . . .\:::::::::::|:::: ::::::/`::::::::: :::::/___,,---‘`’`. . . ."
        puts " . . . . . . . . . . . . . . . . . . . . . . `-:,::::::|,:,:::::::|:::: ::::::::::‹` . . . . . . . . . . "
        puts " . . . . . . . . . . . . . . . . . . . . . . .` `’ ‘ ‘ ‘``’`’ ‘ ` `¯’ ‘ ` ‘ ` ‘ ‘ `. . . . ~Neo . . ."
        
        puts "              8888888b.           888               888888b.            888    888    888"                  
        puts "              888   Y88b          888            ,, 888   88b           888    888    888"
        puts "              888    888          888           //  888  .88P           888    888    888"
        puts "              888   d88P  .d88b.  888  888  .d88b.  8888888K.   8888b.  888888 888888 888  .d88b.  888d888"
        puts "              8888888P   d88  88b 888 .88P d8P  Y8b 888   Y88b      88b 888    888    888 d8P  Y8b 888P"
        puts "              888        888  888 888888K  88888888 888    888 .d888888 888    888    888 88888888 888"
        puts "              888        Y88..88P 888  88b Y8b.     888   d88P 888  888 Y88b.  Y88b.  888 Y8b.     888"
        puts "              888          Y88P   888  888   Y8888  8888888P    Y888888   Y888   Y888 888   Y8888  888"
        puts
        puts
        puts
        puts "                                                                                      Hit enter to continue"
        gets.chomp
    end
end