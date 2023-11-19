module 0x42::SocialNetwork {

    use std::vector; // to allow the use of vectors

    // List of friends, we can't use vector directly
    struct Friends has key, drop, store {
        people: vector<Person>,
    }

    // Structure of a person
    struct Person has key, drop, store, copy {
        name: vector<u8>,
        age: u8,
    }

    // Function to create a friend and add them to the friends list and return the added friend
    public fun create_friend(myFriend: Person, friends: &mut Friends): Person {
        add_friend(friends, myFriend);
        return myFriend
    }

    // Function to add a friend to the friends list
    public fun add_friend(friends: &mut Friends, newFriend: Person) {
        vector::push_back(&mut friends.people, newFriend); // push new friend to the vector friends.people
    }

    # [test]
    fun test_create_friend() {

        let friends = Friends {
            people: vector::empty<Person>(),
        }; // create an empty list in which we will add the created friends

        let richard = Person {
            name: b"Richard", // byte string
            age: 31,
        }; // create a person called Richard of age 31

        let createdFriend = create_friend(richard, &mut friends); // add the friend to the friend list
        assert!(createdFriend.name == b"Richard", 0); // 0 if the name of the friend is Richard, else error
    }
}
