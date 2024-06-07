module act::cosmetic_attributes {
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
        `type`: String,
        colour_way: String,
        edition: String,
        manufacturer: String,
        rarity: String,
        hash: String,
        // kill_count = 0
        // wear_rating to generate randomly
    }

    // === Public mutative functions ===

    public fun unpack_data(
        data: Data
    ): (String, String, String, String, String, String, String, String, String, String) {
        let Data { name, image_url, image_hash, model_url, `type`, colour_way, edition, manufacturer, rarity, hash } = data;
        (name, image_url, image_hash, model_url, `type`, colour_way, edition, manufacturer, rarity, hash)
    }

    // number must be between [0, 10000)
    // for each name we have the same distributions of colour ways here
    public fun random_helm(number: u64): Data {
        assert_number(number);

        let distributions = vector[
            200, 100, 150, 125, 150, 200, 200, 125,
        ]; // 8 times this table
        let names = vector[
            b"Biodome", b"Venom", b"Fang MK IV", b"Scout",
            b"Spectre-09", b"Helios", b"Juggernaut", b"Baha-2000"
        ]; // 8 times each name
        let colour_ways = vector[
            b"Vesper", b"Hikari", b"Volt", b"Blood Ivory", 
            b"Red Damascus", b"Forest", b"Dusk", b"Viceroy"
        ]; // 8 times this table

        let (mut i, mut counter) = (0, 0);
        let (mut name, mut colour_way) = (b"", b"");
        while (counter < number) {
            counter = counter + distributions[i % 8]; // we loop over distributions vec 8 times
            name = names[i / 8]; // we loop over each name 8 times
            colour_way = colour_ways[i % 8]; // we loop over colour_ways vec 8 times

            i = i + 1;
        };

        helm(utf8(name), utf8(colour_way))
    }

    // distribution is scaled to 10000 for 100.00
    public fun helm(name: String, colour_way: String): Data {
        let mut image_url = utf8(b"");
        let mut image_hash = utf8(b"");
        let mut model_url = utf8(b"");
        let `type` = utf8(b"Helm");
        let edition = utf8(b"Genesis");
        let mut manufacturer = utf8(b"");
        let mut rarity = utf8(b"");
        let mut hash = utf8(b"");

        if (name == utf8(b"Biodome")) {
            manufacturer = utf8(b"Astral Exploration Technologies ");
            if (colour_way == utf8(b"Vesper")) {
                image_url = utf8(b"");
                image_hash = utf8(b"");
                model_url = utf8(b"");
                rarity = utf8(b"");
                hash = utf8(b"");
            } else if (colour_way == utf8(b"Hikari")) {
                image_url = utf8(b"");
                image_hash = utf8(b"");
                model_url = utf8(b"");
                rarity = utf8(b"");
                hash = utf8(b"");
            } else if (colour_way == utf8(b"Volt")) {
                image_url = utf8(b"");
                image_hash = utf8(b"");
                model_url = utf8(b"");
                rarity = utf8(b"");
                hash = utf8(b"");
            } else if (colour_way == utf8(b"Blood Ivory")) {
                image_url = utf8(b"");
                image_hash = utf8(b"");
                model_url = utf8(b"");
                rarity = utf8(b"");
                hash = utf8(b"");
            } else if (colour_way == utf8(b"Red Damascus")) {
                image_url = utf8(b"");
                image_hash = utf8(b"");
                model_url = utf8(b"");
                rarity = utf8(b"");
                hash = utf8(b"");
            } else if (colour_way == utf8(b"Forest")) {
                image_url = utf8(b"");
                image_hash = utf8(b"");
                model_url = utf8(b"");
                rarity = utf8(b"");
                hash = utf8(b"");
            } else if (colour_way == utf8(b"Dusk")) {
                image_url = utf8(b"");
                image_hash = utf8(b"");
                model_url = utf8(b"");
                rarity = utf8(b"");
                hash = utf8(b"");
            } else if (colour_way == utf8(b"Viceroy")) {
                image_url = utf8(b"");
                image_hash = utf8(b"");
                model_url = utf8(b"");
                rarity = utf8(b"");
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
            `type`,
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

