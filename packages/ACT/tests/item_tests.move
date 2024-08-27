#[test_only]
module act::item_tests {

    use act::item;

    public struct InvalidOTW has drop {}

    public struct Rule has drop {}

    public struct Character has key, store {
        id: UID
    }

    #[test]
    #[expected_failure(abort_code = item::ENotAOneTimeWitness)]
    fun test_unequip_error_type_not_equipped() {
        let mut ctx = tx_context::dummy();

        item::init_state<InvalidOTW, Rule, Character>(InvalidOTW {}, b"otw".to_string(), b"description".to_string(), &mut ctx);   
    }
}