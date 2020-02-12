class Trainer < ActiveRecord::Base
    has_many :pokemons
    has_many :battles, through: :pokemons

    def pick_pokemon
        remove_id_if_found = Pokemon.all.find{|p| p.trainer_id == self.id}
        if remove_id_if_found != nil
            remove_id_if_found.trainer_id = nil
            remove_id_if_found.save
        end
        available_list = Pokemon.all.select{|p| p.trainer_id == nil}
        choice = available_list.sample
        choice.trainer_id = self.id
        choice.save
        choice
    end

    def battle!
        available_list = Trainer.all.select{|t| t != self}
        rival = available_list.sample
        rival.pick_pokemon
        user_pokemon = Pokemon.all.find{|p| p.trainer_id == self.id}
        rival_pokemon = Pokemon.all.find{|p| p.trainer_id == rival.id}
        battle = Battle.create(pokemon_1_id: user_pokemon.id, pokemon_2_id: rival_pokemon.id)
        battle.id_one = user_pokemon.id
        battle.id_two = rival_pokemon.id
        result = battle.start
        rival_pokemon.update(trainer_id: nil)
        if result == self.id
            puts "You won!"
        else
            puts "You lost."
        end
    end

    def retire
        self.delete
    end
end