// ex utils
module act::attributes {
    // === Imports ===

    use std::string::String;
    use sui::vec_map::{Self, VecMap};

    // === Errors ===

    const EInvalidAttribute: u64 = 0;

    // === Constants ===

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

    // === Structs ===

    // === Method Aliases ===

    // === Public Package Functions ===

    public(package) fun new(): VecMap<String, String> {
        let mut attributes = vec_map::empty();
        // Default cosmetics
        let mut i = 0;
        let cosmetic_types = cosmetic_types(); 
        let len = cosmetic_types.length();
        while (len > i) {
            attributes.insert(cosmetic_types[i], b"".to_string());
            i = i + 1;
        };
        // Default weapons
        attributes.insert(primary(), b"".to_string());
        attributes.insert(secondary(), b"".to_string());
        attributes.insert(tertiary(), b"".to_string());

        attributes
    }

    public(package) fun new_hashes(): VecMap<String, vector<u8>> {
        let mut attributes = vec_map::empty();
        // Default cosmetics
        let mut i = 0;
        let cosmetic_types = cosmetic_types(); 
        let len = cosmetic_types.length();
        while (len > i) {
            attributes.insert(cosmetic_types[i], vector[]);
            i = i + 1;
        };
        // Default weapons
        attributes.insert(primary(), vector[]);
        attributes.insert(secondary(), vector[]);
        attributes.insert(tertiary(), vector[]);

        attributes
    }

    public(package) fun assert_is_valid_cosmetic(str: &String) {
        assert!(cosmetic_types().contains(str), EInvalidAttribute);
    }

    public(package) fun assert_is_valid_weapon(str: &String) {
        assert!(weapon_types().contains(str), EInvalidAttribute);
    }

    public(package) fun cosmetic_types(): vector<String> {
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
    }

    public(package) fun weapon_types(): vector<String> {
        vector[
            PRIMARY.to_string(),
            SECONDARY.to_string(),
            TERTIARY.to_string(),
        ]
    }

    public(package) fun types(): vector<String> {
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
            PRIMARY.to_string(),
            SECONDARY.to_string(),
            TERTIARY.to_string(),
        ]        
    }

    // @dev There is no backpiece nor accessory in the genesis mint
    public(package) fun genesis_mint_types(): vector<String> {
        vector[
            HELM.to_string(),
            UPPER_TORSO.to_string(),
            CHESTPIECE.to_string(),
            LEFT_ARM.to_string(),
            RIGHT_ARM.to_string(),
            LEFT_BRACER.to_string(),
            RIGHT_BRACER.to_string(),
            LEFT_GLOVE.to_string(),
            RIGHT_GLOVE.to_string(),
            LEFT_PAULDRON.to_string(),
            RIGHT_PAULDRON.to_string(),
            LEGS.to_string(),
            SHINS.to_string(),
            BOOTS.to_string(),
            PRIMARY.to_string(),
            SECONDARY.to_string(),
            TERTIARY.to_string(),
        ]        
    }

    public(package) fun helm(): String { HELM.to_string() }
    public(package) fun chestpiece(): String { CHESTPIECE.to_string() }
    public(package) fun backpiece(): String { BACKPIECE.to_string() }
    public(package) fun upper_torso(): String { UPPER_TORSO.to_string() }
    public(package) fun right_pauldron(): String { RIGHT_PAULDRON.to_string() }
    public(package) fun left_pauldron(): String { LEFT_PAULDRON.to_string() }
    public(package) fun right_arm(): String { RIGHT_ARM.to_string() }
    public(package) fun left_arm(): String { LEFT_ARM.to_string() }
    public(package) fun right_glove(): String { RIGHT_GLOVE.to_string() }
    public(package) fun left_glove(): String { LEFT_GLOVE.to_string() }
    public(package) fun right_bracer(): String { RIGHT_BRACER.to_string() }
    public(package) fun left_bracer(): String { LEFT_BRACER.to_string() }
    public(package) fun legs(): String { LEGS.to_string() }
    public(package) fun belt(): String { BELT.to_string() }
    public(package) fun shins(): String { SHINS.to_string() }
    public(package) fun boots(): String { BOOTS.to_string() }
    public(package) fun accessory(): String { ACCESSORY.to_string() }

    public(package) fun primary(): String { PRIMARY.to_string() }
    public(package) fun secondary(): String { SECONDARY.to_string() }
    public(package) fun tertiary(): String { TERTIARY.to_string() }

    public(package) fun helm_bytes(): vector<u8> { HELM }
    public(package) fun chestpiece_bytes(): vector<u8>  { CHESTPIECE }
    public(package) fun backpiece_bytes(): vector<u8>  { BACKPIECE }
    public(package) fun upper_torso_bytes(): vector<u8>  { UPPER_TORSO }
    public(package) fun right_pauldron_bytes(): vector<u8>  { RIGHT_PAULDRON }
    public(package) fun left_pauldron_bytes(): vector<u8>  { LEFT_PAULDRON }
    public(package) fun right_arm_bytes(): vector<u8>  { RIGHT_ARM }
    public(package) fun left_arm_bytes(): vector<u8>  { LEFT_ARM }
    public(package) fun right_glove_bytes(): vector<u8>  { RIGHT_GLOVE }
    public(package) fun left_glove_bytes(): vector<u8>  { LEFT_GLOVE }
    public(package) fun right_bracer_bytes(): vector<u8>  { RIGHT_BRACER }
    public(package) fun left_bracer_bytes(): vector<u8>  { LEFT_BRACER }
    public(package) fun legs_bytes(): vector<u8>  { LEGS }
    public(package) fun belt_bytes(): vector<u8>  { BELT }
    public(package) fun shins_bytes(): vector<u8>  { SHINS }
    public(package) fun boots_bytes(): vector<u8>  { BOOTS }
    public(package) fun accessory_bytes(): vector<u8>  { ACCESSORY }

    public(package) fun primary_bytes(): vector<u8>  { PRIMARY }
    public(package) fun secondary_bytes(): vector<u8> { SECONDARY }
    public(package) fun tertiary_bytes(): vector<u8> { TERTIARY }

    // === Admin Functions ===

    // === Public-Package Functions ===

    // === Private Functions ===

    // === Test Functions ===
}