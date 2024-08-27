#[test_only]
module act::attributes_tests {

    use std::string::String;
    
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
    const BELT: vector<u8> = b"Belt";
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
        assert_eq(values, new_empty_values());
    }

    #[test]
    fun test_assert_is_valid_cosmetic() {
        attributes::assert_is_valid_cosmetic(&HELM.to_string());
        attributes::assert_is_valid_cosmetic(&UPPER_TORSO.to_string());
        attributes::assert_is_valid_cosmetic(&CHESTPIECE.to_string());
        attributes::assert_is_valid_cosmetic(&BACKPIECE.to_string());
        attributes::assert_is_valid_cosmetic(&LEFT_ARM.to_string());
        attributes::assert_is_valid_cosmetic(&RIGHT_ARM.to_string());
        attributes::assert_is_valid_cosmetic(&LEFT_BRACER.to_string());
        attributes::assert_is_valid_cosmetic(&RIGHT_BRACER.to_string());
        attributes::assert_is_valid_cosmetic(&LEFT_GLOVE.to_string());
        attributes::assert_is_valid_cosmetic(&RIGHT_GLOVE.to_string());
        attributes::assert_is_valid_cosmetic(&LEFT_PAULDRON.to_string());
        attributes::assert_is_valid_cosmetic(&RIGHT_PAULDRON.to_string());
        attributes::assert_is_valid_cosmetic(&LEGS.to_string());
        attributes::assert_is_valid_cosmetic(&ACCESSORY.to_string());
        attributes::assert_is_valid_cosmetic(&SHINS.to_string());
        attributes::assert_is_valid_cosmetic(&BOOTS.to_string());
    }

    #[test]
    fun test_assert_is_valid_weapon() {
        attributes::assert_is_valid_weapon(&PRIMARY.to_string());
        attributes::assert_is_valid_weapon(&SECONDARY.to_string());
        attributes::assert_is_valid_weapon(&TERTIARY.to_string());
    }

    #[test]
    fun test_cosmetic_types() {
        assert_eq(attributes::cosmetic_types(), 
        vector[
                HELM.to_string(),
                UPPER_TORSO.to_string(),
                CHESTPIECE.to_string(),
                BACKPIECE.to_string(),
                LEFT_ARM.to_string(),
                RIGHT_ARM.to_string(),
                LEFT_BRACER.to_string(),
                RIGHT_BRACER.to_string(),
                LEFT_GLOVE.to_string(),
                RIGHT_GLOVE.to_string(),
                LEFT_PAULDRON.to_string(),
                RIGHT_PAULDRON.to_string(),
                LEGS.to_string(),
                BELT.to_string(),
                ACCESSORY.to_string(),
                SHINS.to_string(),
                BOOTS.to_string(),  
            ]
        );
    }

    #[test]
    fun test_weapon_types() {
        assert_eq(attributes::weapon_types(), 
        vector[
                PRIMARY.to_string(),
                SECONDARY.to_string(),
                TERTIARY.to_string(),
            ]
        );
    }

    #[test]
    fun test_constants() {
        assert_eq(attributes::helm(), HELM.to_string());
        assert_eq(attributes::chestpiece(), CHESTPIECE.to_string());
        assert_eq(attributes::backpiece(), BACKPIECE.to_string());
        assert_eq(attributes::upper_torso(), UPPER_TORSO.to_string());
        assert_eq(attributes::right_pauldron(), RIGHT_PAULDRON.to_string());
        assert_eq(attributes::left_pauldron(), LEFT_PAULDRON.to_string());
        assert_eq(attributes::right_arm(), RIGHT_ARM.to_string());
        assert_eq(attributes::left_arm(), LEFT_ARM.to_string());
        assert_eq(attributes::right_glove(), RIGHT_GLOVE.to_string());
        assert_eq(attributes::left_glove(), LEFT_GLOVE.to_string());
        assert_eq(attributes::right_bracer(), RIGHT_BRACER.to_string());
        assert_eq(attributes::left_bracer(), LEFT_BRACER.to_string());
        assert_eq(attributes::legs(), LEGS.to_string());
        assert_eq(attributes::shins(), SHINS.to_string());
        assert_eq(attributes::boots(), BOOTS.to_string());
        assert_eq(attributes::accessory(), ACCESSORY.to_string());

        assert_eq(attributes::primary(), PRIMARY.to_string());
        assert_eq(attributes::secondary(), SECONDARY.to_string());
        assert_eq(attributes::tertiary(), TERTIARY.to_string());
    }

    #[test]
    fun test_formatted_types() {
        assert_eq(attributes::make_formatted_type(attributes::helm()), HELM.to_string());
        assert_eq(attributes::make_formatted_type(attributes::chestpiece()), CHESTPIECE.to_string());
        assert_eq(attributes::make_formatted_type(attributes::backpiece()), BACKPIECE.to_string());
        assert_eq(attributes::make_formatted_type(attributes::upper_torso()), UPPER_TORSO.to_string());
        assert_eq(attributes::make_formatted_type(attributes::right_pauldron()), b"Pauldron (R)".to_string());
        assert_eq(attributes::make_formatted_type(attributes::left_pauldron()), b"Pauldron (L)".to_string());
        assert_eq(attributes::make_formatted_type(attributes::right_arm()), b"Arm (R)".to_string());
        assert_eq(attributes::make_formatted_type(attributes::left_arm()), b"Arm (L)".to_string());
        assert_eq(attributes::make_formatted_type(attributes::right_glove()), b"Glove (R)".to_string());
        assert_eq(attributes::make_formatted_type(attributes::left_glove()), b"Glove (L)".to_string());
        assert_eq(attributes::make_formatted_type(attributes::right_bracer()), b"Bracer (R)".to_string());
        assert_eq(attributes::make_formatted_type(attributes::left_bracer()), b"Bracer (L)".to_string());
        assert_eq(attributes::make_formatted_type(attributes::legs()), LEGS.to_string());
        assert_eq(attributes::make_formatted_type(attributes::shins()), SHINS.to_string());
        assert_eq(attributes::make_formatted_type(attributes::boots()), BOOTS.to_string());
        assert_eq(attributes::make_formatted_type(attributes::accessory()), ACCESSORY.to_string());
    }

    fun new_empty_values(): vector<String> {
        let mut data = vector[];

        let mut i = 0;
        while (20 > i) {
            data.push_back(b"".to_string());
            i = i + 1;
        };

        data
    } 
}