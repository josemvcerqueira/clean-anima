/// this module has a function hardcoding all fields of a weapon slot like principal()
/// then there is a function to generate a random principal weapon 
/// the Data generated is supposed to be added in ./drop.move -> Sale.drops
/// we can either store the Whole Data or just the (name, colour_way) pair
/// if we store the pair we generate the Data upon mint

module act::weapon_attributes {
    use std::string::{utf8, String};

    // === Errors ===

    const EWrongColourWay: u64 = 0;
    const EWrongName: u64 = 1;
    const ENumberTooHigh: u64 = 2;

    // === Structs ===

    public struct Data has store, drop {
        name: String,
        image_url: String,
        image_hash: String,
        model_url: String,
        slot: String,
        colour_way: String,
        edition: String,
        manufacturer: String,
        rarity: String,
        hash: String,
        // kill_count = 0
        // wear_rating to generate randomly
    }

    // === Public mutative functions ===

    public fun unpack(
        data: Data
    ): (String, String, String, String, String, String, String, String, String, String) {
        let Data { name, image_url, image_hash, model_url, slot, colour_way, edition, manufacturer, rarity, hash } = data;
        (name, image_url, image_hash, model_url, slot, colour_way, edition, manufacturer, rarity, hash)
    }

    // number must be between [0, 10000)
    public fun random_primary(number: u64): Data {
        assert_number(number);

        let distributions = vector[
            364, 260, 364, 260, 364, 364, 364, 260, 308, 220, 308, 
            220, 308, 308, 308, 220, 364, 260, 364, 260, 364, 364, 
            364, 260, 364, 260, 364, 260, 364, 364, 364, 260
        ];
        let names = vector[
            b"Talon", b"Talon", b"Talon", b"Talon", 
            b"Talon", b"Talon", b"Talon", b"Talon", 
            b"Renegade", b"Renegade", b"Renegade", b"Renegade", 
            b"Renegade", b"Renegade", b"Renegade", b"Renegade", 
            b"Raptor", b"Raptor", b"Raptor", b"Raptor", 
            b"Raptor", b"Raptor", b"Raptor", b"Raptor", 
            b"12 Guage", b"12 Guage", b"12 Guage", b"12 Guage", 
            b"12 Guage", b"12 Guage", b"12 Guage", b"12 Guage"
        ];
        let colour_ways = vector[
            b"Vesper", b"Hikari", b"Volt", b"Blood Ivory", 
            b"Red Damascus", b"Forest", b"Dusk", b"Viceroy", 
            b"Vesper", b"Hikari", b"Volt", b"Blood Ivory", 
            b"Red Damascus", b"Forest", b"Dusk", b"Viceroy", 
            b"Vesper", b"Hikari", b"Volt", b"Blood Ivory", 
            b"Red Damascus", b"Forest", b"Dusk", b"Viceroy", 
            b"Vesper", b"Hikari", b"Volt", b"Blood Ivory", 
            b"Red Damascus", b"Forest", b"Dusk", b"Viceroy"
        ];

        let (mut i, mut counter) = (0, 0);
        let (mut name, mut colour_way) = (b"", b"");
        while (counter < number) {
            counter = counter + distributions[i];
            name = names[i];
            colour_way = colour_ways[i];

            i = i + 1;
        };

        primary(utf8(name), utf8(colour_way))
    }

    // distribution is scaled to 10000 for 100.00
    public fun primary(name: String, colour_way: String): Data {
        let mut image_url = utf8(b"");
        let mut image_hash = utf8(b"");
        let mut model_url = utf8(b"");
        let slot = utf8(b"Primary");
        let edition = utf8(b"Genesis");
        let mut manufacturer = utf8(b"");
        let mut rarity = utf8(b"");
        let mut hash = utf8(b"");

        if (name == utf8(b"Talon")) {
            manufacturer = utf8(b"Fenrir Arms");
            if (colour_way == utf8(b"Vesper")) {
                image_url = utf8(b"");
                image_hash = utf8(b"");
                model_url = utf8(b"");
                rarity = utf8(b"Ultra Rare");
                hash = utf8(b"");
            } else if (colour_way == utf8(b"Hikari")) {
                image_url = utf8(b"");
                image_hash = utf8(b"");
                model_url = utf8(b"");
                rarity = utf8(b"Mythic");
                hash = utf8(b"");
            } else if (colour_way == utf8(b"Volt")) {
                image_url = utf8(b"");
                image_hash = utf8(b"");
                model_url = utf8(b"");
                rarity = utf8(b"Ultra Rare");
                hash = utf8(b"");
            } else if (colour_way == utf8(b"Blood Ivory")) {
                image_url = utf8(b"");
                image_hash = utf8(b"");
                model_url = utf8(b"");
                rarity = utf8(b"Mythic");
                hash = utf8(b"");
            } else if (colour_way == utf8(b"Red Damascus")) {
                image_url = utf8(b"");
                image_hash = utf8(b"");
                model_url = utf8(b"");
                rarity = utf8(b"Ultra Rare");
                hash = utf8(b"");
            } else if (colour_way == utf8(b"Forest")) {
                image_url = utf8(b"");
                image_hash = utf8(b"");
                model_url = utf8(b"");
                rarity = utf8(b"Ultra Rare");
                hash = utf8(b"");
            } else if (colour_way == utf8(b"Dusk")) {
                image_url = utf8(b"");
                image_hash = utf8(b"");
                model_url = utf8(b"");
                rarity = utf8(b"Ultra Rare");
                hash = utf8(b"");
            } else if (colour_way == utf8(b"Viceroy")) {
                image_url = utf8(b"");
                image_hash = utf8(b"");
                model_url = utf8(b"");
                rarity = utf8(b"Mythic");
                hash = utf8(b"");
            } else {
                abort EWrongColourWay
            };

        } else if (name == utf8(b"Renegade")) {
            
        } else {
            abort EWrongName
        };

        Data {
            name,
            image_url,
            image_hash,
            model_url,
            slot,
            colour_way,
            edition,
            manufacturer,
            rarity,
            hash,
        }
    }

    // === Private funtions ===

    fun assert_number(number: u64){
        assert!(number < 10000, ENumberTooHigh);
    }
}

