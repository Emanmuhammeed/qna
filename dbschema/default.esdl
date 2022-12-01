module default {
    abstract type Person {
        required property name -> str;
        multi link places_visited -> Place;
        single link lover -> Person;
        property is_single := not exists .lover;
    }

    # player character
    type PC extending Person {
        required property transport -> Transport;
        property age -> HumanAge;
    }

    # non-player character
    type NPC extending Person {
        property age -> HumanAge;
    }

    type Vampire extending Person {
        property age -> int16;
    }

    abstract type Place {
        required property name -> str;
        property modern_name -> str;
        property important_places -> array<str>;
    }

    type City extending Place;

    type Country extending Place;

    type Time {
        required property clock -> str {
            constraint expression on (len(__subject__) = 8)
        }
        property clock_time := <cal::local_time>.clock;
        property hour := .clock[0:2];
        property is_awake := awake.Awake IF (<int16>.hour > 19) And (<int16>.hour < 7) ELSE awake.Asleep;
    }

    scalar type Transport extending enum<Feet, Train, HorseDrawnCarriage>;

    scalar type HumanAge extending int16{
        constraint max_value(120);
        constraint min_value(0);
    }

    scalar type awake extending enum<Awake, Asleep>;

}
