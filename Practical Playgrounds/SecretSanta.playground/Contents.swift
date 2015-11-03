//:# Secret Santa

//: Test shuffle method
var people = [Person(firstName: "Ryan", lastName: "Grey", email: "rgrey@scottlogic.com"),
                Person(firstName: "Rob", lastName: "Pilling", email: "rpilling@scottlogic.com"),
                Person(firstName: "Andy", lastName: "Polkinghorn", email: "apolkinghorn@scottlogic.com"),
                Person(firstName: "Chris", lastName: "Grant", email: "cgrant@scottlogic.com"),
                Person(firstName: "Sam", lastName: "Burnstone", email: "sburnstone@scottlogic.com")
                ];

let santa = SecretSantaGenerator()

//:## TEST GENERATION NOT POSSIBLE

func test_error_thrown_when_generating_with_participant_count_of_1()
{
    let sam = Person(firstName: "Sam", lastName: "Burnstone", email: "sburnstone@scottlogic.com")
    do
    {
        try santa.generatePairingsFromParticipants([sam])
    }
    catch SecretSantaGenerator.Error.TooFewParticipants // Not sure whether a nested error type is the best way to go about this
    {
        print("\(__FUNCTION__) ✔︎")
        print("Too few participants")
    }
    catch {}
}

func test_generation_not_possible_when_all_participants_from_same_family()
{
    let ryan = Person(firstName: "Ryan", lastName: "Grey", email: "rgrey@scottlogic.com")
    let stu = Person(firstName: "Stu", lastName: "Grey", email: "sgrey@scottlogic.com")
    
    do
    {
        try santa.generatePairingsFromParticipants([ryan, stu])
    }
    catch SecretSantaGenerator.Error.InsufficientNumberOfParticipantsFromSeparateFamilies
    {
         print("\(__FUNCTION__) ✔︎")
        print("No possible pairings - too many from same family")
    }
    catch {}
}

func test_generation_not_possible_when_majority_of_participants_from_same_family()
{
    let ryan = Person(firstName: "Ryan", lastName: "Grey", email: "rgrey@scottlogic.com")
    let stu = Person(firstName: "Stu", lastName: "Grey", email: "sgrey@scottlogic.com")
    let sam = Person(firstName: "Sam", lastName: "Burnstone", email: "sburnstone@scottlogic.com")
    
    do
    {
        try santa.generatePairingsFromParticipants([ryan, stu, sam])
    }
    catch SecretSantaGenerator.Error.InsufficientNumberOfParticipantsFromSeparateFamilies
    {
        print("\(__FUNCTION__) ✔︎")
        print("No possible pairings - too many from same family")
    }
    catch {}
}

//:## TEST GENERATION IS POSSIBLE

func test_generation_is_possible_when_half_of_participants_do_not_share_family_name()
{
    let ryan = Person(firstName: "Ryan", lastName: "Grey", email: "rgrey@scottlogic.com")
    let stu = Person(firstName: "Stu", lastName: "Grey", email: "sgrey@scottlogic.com")
    let sam = Person(firstName: "Sam", lastName: "Burnstone", email: "sburnstone@scottlogic.com")
    let tom = Person(firstName: "Tom", lastName: "Burnstone", email: "tburnstone@scottlogic.com")
    
    do
    {
        print(try santa.generatePairingsFromParticipants([ryan, stu, sam, tom]))
        print("\(__FUNCTION__) ✔︎")
    }
    catch SecretSantaGenerator.Error.InsufficientNumberOfParticipantsFromSeparateFamilies
    {
        print("No possible pairings - too many from same family")
    }
    catch {}
}

// Valid participants -> test secret santa list generated
func test_generation_is_possible_when_all_participants_from_different_families()
{
    do
    {
        print(try santa.generatePairingsFromParticipants(people))
        print("\(__FUNCTION__) ✔︎")
    }
    catch {}
}

print("\nInvalid input tests")
test_generation_not_possible_when_all_participants_from_same_family()
test_generation_not_possible_when_majority_of_participants_from_same_family()
test_error_thrown_when_generating_with_participant_count_of_1()

print("\nValid input tests")
test_generation_is_possible_when_all_participants_from_different_families()
test_generation_is_possible_when_half_of_participants_do_not_share_family_name()

