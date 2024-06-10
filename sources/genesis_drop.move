/*
* @title Genesis Drop
* @description
*
* 1 - 
*/
module act::act_genesis_drop {
    // === Imports ===

    use std::string::utf8;
    use sui::{random::Random};
    use act::{
        act_weapon,
        attributes,
        act_cosmetic,
        act_avatar::Avatar,
        act_genesis_shop::GenesisShop
    };

    // === Errors ===

    // === Constants ===

    const WEAR_RATING_MAX: u64 = 1_000_000_000;

    // === Structs ===
    
    // TODO handle distribution
    public struct GenesisPass has key {
        id: UID
    }

    // === Method Aliases ===

    // === Public-Mutative Functions ===
    
    // TODO HANDLE PRICE + FIRSTS/SECOND MINT and other stuff
    // @dev Equips the avatar with 16 random items + 3 weapons 
    // It will error out if it already has items
    entry fun first_mint(
        genesis_shop: &mut GenesisShop,
        random: &Random,
        avatar: &mut Avatar,
        _: &GenesisPass,
        ctx: &mut TxContext
    ) {
        let all_types = attributes::types();
        let mut i = 0;
        let len = all_types.length();
        let mut gen = random.new_generator(ctx);

        while (len > i) {
            let shop = genesis_shop.borrow_mut(utf8(all_types[i]));
            let items = shop.items();

            let total_items = items.length();

            let index = if (total_items == 1) { 0 } else { gen.generate_u64_in_range(0, total_items - 1) };

            let item = items.swap_remove(index);
            let (name, kinds, colour_way, manufacturer, rarity, is_cosmetic) = item.unpack();
            let len = kinds.length();
            let mut j = 0;

            while (len > j) {
                let kind = kinds[j];

                if (is_cosmetic) {
                    let cosmetic = act_cosmetic::new(
                        name,
                        utf8(b""),
                        utf8(b""),
                        utf8(b""),
                        kind,
                        colour_way,
                        utf8(b"Genesis"),
                        manufacturer,
                        rarity,
                        utf8(b""),
                        gen.generate_u64_in_range(0, WEAR_RATING_MAX),
                        ctx
                    );
                    avatar.equip_minted_cosmetic(cosmetic);
                } else {
                    let weapon = act_weapon::new(
                        name,
                        utf8(b""),
                        utf8(b""),
                        utf8(b""),
                        kind,
                        colour_way,
                        utf8(b"Genesis"),
                        manufacturer,
                        rarity,
                        utf8(b""),
                        gen.generate_u64_in_range(0, WEAR_RATING_MAX),
                        ctx
                    );
                    avatar.equip_minted_weapon(weapon);
                };

                j = j + 1;
            };
            i = i + 1;
        };
    }

    // === Public-View Functions ===

    // === Admin Functions ===

    // === Public-Package Functions ===

    // === Private Functions ===

    // === Test Functions ===
}
