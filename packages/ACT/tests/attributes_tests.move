#[test_only]
module act::attributes_tests {
    
    use sui::{
        test_utils::assert_eq,
    };

    use act::attributes;


    const HELM: vector<u8> = b"Helm";
    const UPPER_TORSO: vector<u8> = b"Upper Torso";
    const CHESTPIECE: vector<u8> = b"Chestpiece";
    const BACKPIECE: vector<u8> = b"Backpiece";
    const LEFT_ARM: vector<u8> = b"Left Arm";
    const RIGHT_ARM: vector<u8> = b"Right Arm";
    const LEFT_BRACER: vector<u8> = b"Left Bracer";
    const RIGHT_BRACER: vector<u8> = b"Right Bracer";
    const LEFT_GLOVE: vector<u8> = b"Left Glove";
    const RIGHT_GLOVE: vector<u8> = b"Right Glove";
    const LEFT_PAULDRON: vector<u8> = b"Left Pauldron";
    const RIGHT_PAULDRON: vector<u8> = b"Right Pauldron";
    const LEGS: vector<u8> = b"Legs";
    const ACCESSORY: vector<u8> = b"Accessory";
    const SHINS: vector<u8> = b"Shins";
    const BOOTS: vector<u8> = b"Boots";

    const PRIMARY: vector<u8> = b"Primary";
    const SECONDARY: vector<u8> = b"Secondary";
    const TERTIARY: vector<u8> = b"Tertiary";

    #[test]
    fun test_new() {
        let attr = attributes::new();

        let (keys, values) = attr.into_keys_values();

        assert_eq(attr.size(), attributes::types().length());
        assert_eq(keys, attributes::types());
        assert_eq(values, vector[]);
    }
}