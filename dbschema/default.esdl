module default {
    type User {
        required property first_name -> str;
        required property last_name -> str;
        required property username -> str {
            constraint exclusive;
        }
        required property age -> Age;
        multi link posts -> Post;

    }

    abstract type Post {
        required property content -> str;
        property upvote -> {
            default := 0; 
        }
        property downvote -> {
            default := 0; 
        }
        single link author -> Person;
    }

    type Question extending Post {
        required property title -> str;
        required property tags -> array<str>;
        multi link comments -> Comment;
        multi link answer -> Answer;
    }

    type Answer extending Post {
        multi link comments -> Comment;
    }

    type Comment extending Post {

    }

    scalar type Age extending int16{
        constraint max_value(120);
        constraint min_value(0);
    }
}
