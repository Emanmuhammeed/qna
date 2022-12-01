CREATE MIGRATION m1s2wlw7ccedcz3heo7van2ulbmo4iin426jvdvda63vz2jmy2lwka
    ONTO initial
{
  CREATE FUTURE nonrecursive_access_policies;
  CREATE ABSTRACT TYPE default::Place {
      CREATE PROPERTY important_places -> array<std::str>;
      CREATE PROPERTY modern_name -> std::str;
      CREATE REQUIRED PROPERTY name -> std::str;
  };
  CREATE TYPE default::City EXTENDING default::Place;
  CREATE TYPE default::Country EXTENDING default::Place;
  CREATE SCALAR TYPE default::HumanAge EXTENDING std::int16 {
      CREATE CONSTRAINT std::max_value(120);
      CREATE CONSTRAINT std::min_value(0);
  };
  CREATE ABSTRACT TYPE default::Person {
      CREATE SINGLE LINK lover -> default::Person;
      CREATE PROPERTY is_single := (NOT (EXISTS (.lover)));
      CREATE MULTI LINK places_visited -> default::Place;
      CREATE REQUIRED PROPERTY name -> std::str;
  };
  CREATE TYPE default::NPC EXTENDING default::Person {
      CREATE PROPERTY age -> default::HumanAge;
  };
  CREATE SCALAR TYPE default::Transport EXTENDING enum<Feet, Train, HorseDrawnCarriage>;
  CREATE TYPE default::PC EXTENDING default::Person {
      CREATE PROPERTY age -> default::HumanAge;
      CREATE REQUIRED PROPERTY transport -> default::Transport;
  };
  CREATE TYPE default::Vampire EXTENDING default::Person {
      CREATE PROPERTY age -> std::int16;
  };
  CREATE SCALAR TYPE default::awake EXTENDING enum<Awake, Asleep>;
  CREATE TYPE default::Time {
      CREATE REQUIRED PROPERTY clock -> std::str {
          CREATE CONSTRAINT std::expression ON ((std::len(__subject__) = 8));
      };
      CREATE PROPERTY clock_time := (<cal::local_time>.clock);
      CREATE PROPERTY hour := ((.clock)[0:2]);
      CREATE PROPERTY is_awake := ((default::awake.Awake IF ((<std::int16>.hour > 19) AND (<std::int16>.hour < 7)) ELSE default::awake.Asleep));
  };
};
