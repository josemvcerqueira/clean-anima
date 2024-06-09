/// in this module (name, colour_way) pair will be associated to (image_url, image_hash, model_url)

module act::uris {
    use std::string::{utf8, String};
    use act::act_factory::{Self, Item};
    use act::attributes;

    public fun get_weapon_uris(name: String, colour_way: String): (String, String, String) {
        // get the uri from the name and colour_way
        (utf8(b"image_url"), utf8(b"image_hash"), utf8(b"model_url"))
    }

    public fun get_cosmetic_uris(name: String, colour_way: String): (String, String, String) {
        // get the uri from the name and colour_way
        (utf8(b"image_url"), utf8(b"image_hash"), utf8(b"model_url"))
    }
}

