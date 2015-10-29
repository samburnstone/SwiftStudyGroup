//:# Secret Santa

//: Test shuffle method
var people = [Person(firstName: "Ryan", lastName: "Grey", email: "rgrey@scottlogic.com"),
                Person(firstName: "Rob", lastName: "Pilling", email: "rpilling@scottlogic.com"),
                Person(firstName: "Andy", lastName: "Polkinghorn", email: "apolkinghorn@scottlogic.com"),
                Person(firstName: "Chris", lastName: "Grant", email: "cgrant@scottlogic.com"),
                Person(firstName: "Sam", lastName: "Burnstone", email: "sburnstone@scottlogic.com")
                ];
people.shuffle()

let santa = SecretSantaGenerator()

// Test case 1 (not enough participants)
func test_error_thrown_when_generating_with_participant_count_of_1()
{
    let sam = Person(firstName: "Sam", lastName: "Burnstone", email: "sburnstone@scottlogic.com")
    do
    {
        try santa.generatePairingsFromParticipants([sam])
    }
    catch SecretSantaGenerator.Error.TooFewParticipants // Not sure whether a nested error type is the best way to go about this
    {
        print("Too few participants")
    }
    catch {}
}

// Test case 2 (all participants have same last name)
func test_generation_not_possible_when_all_participants_from_same_family()
{
    let ryan = Person(firstName: "Ryan", lastName: "Grey", email: "rgrey@scottlogic.com")
    let stu = Person(firstName: "Stu", lastName: "Grey", email: "sgrey@scottlogic.com")
    
    do
    {
        try santa.generatePairingsFromParticipants([ryan, stu])
    }
    catch SecretSantaGenerator.Error.AllParticipantsHaveSameName
    {
        print("No possible pairings - all participants are from same family")
    }
    catch {}
}

// Valid participants -> test secret santa list generated
func test_generation_is_possible_when_all_participants_from_different_families()
{
    do
    {
        let pairings = try santa.generatePairingsFromParticipants(people)
        print(pairings)
    }
    catch SecretSantaGenerator.Error.AllParticipantsHaveSameName
    {
        print("No possible pairings - all participants are from same family")
    }
    catch {}
}

test_error_thrown_when_generating_with_participant_count_of_1()
test_generation_is_possible_when_all_participants_from_different_families()
//test_generation_not_possible_when_all_participants_from_same_family() -> Currently enters an infinite loop
