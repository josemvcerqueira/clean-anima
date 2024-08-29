module act::profile_pictures {
 
    use std::string::String;
    use sui::{
        table::{Self, Table},
        hash,
    };
    use animalib::{
        access_control::{Admin, AccessControl},
        admin,
    };

    const EProfilePictureNotFound: u64 = 0;

    public struct ProfilePictures has key {
        id: UID,
        hash_to_ipfs: Table<vector<u8>, String>,
    }

    fun init(ctx: &mut TxContext) {
        transfer::share_object(ProfilePictures {
            id: object::new(ctx),
            hash_to_ipfs: table::new(ctx),
        });
    }

    public fun add(
        profile_pictures: &mut ProfilePictures,
        access_control: &AccessControl,
        admin: &Admin,
        hash: vector<u8>,
        ipfs_url: String,
    ) {
        admin::assert_profile_pictures_role(access_control, admin);
        profile_pictures.hash_to_ipfs.add(hash, ipfs_url);
    }

    public fun remove(
        profile_pictures: &mut ProfilePictures,
        access_control: &AccessControl,
        admin: &Admin,
        hash: vector<u8>, 
    ) {
        admin::assert_profile_pictures_role(access_control, admin);
        profile_pictures.hash_to_ipfs.remove(hash);
    }

    public fun get(
        profile_pictures: &ProfilePictures, 
        helm: vector<u8>,
        chestpiece: vector<u8>,
        upper_torso: vector<u8>
    ): String {
        let hash = cosmetic_to_pfp_hash(helm, chestpiece, upper_torso);
        assert!(profile_pictures.hash_to_ipfs.contains(hash), EProfilePictureNotFound);
        *profile_pictures.hash_to_ipfs.borrow(hash)
    }

    public fun contains(
        profile_pictures: &ProfilePictures, 
        helm: vector<u8>,
        chestpiece: vector<u8>,
        upper_torso: vector<u8>
    ): bool {
        let hash = cosmetic_to_pfp_hash(helm, chestpiece, upper_torso);
        profile_pictures.hash_to_ipfs.contains(hash)
    }

    public fun cosmetic_to_pfp_hash(
        helm: vector<u8>,
        chestpiece: vector<u8>,
        upper_torso: vector<u8>
    ): vector<u8> {
        let mut vec = vector[];
        vec.append(if (helm.is_empty()) b"empty" else helm);
        vec.append(if (chestpiece.is_empty()) b"empty" else chestpiece);
        vec.append(if (upper_torso.is_empty()) b"empty" else upper_torso);

        hash::blake2b256(&vec)
    }

    public fun hash_to_ipfs(profile_pictures: &ProfilePictures): &Table<vector<u8>, String> {
        &profile_pictures.hash_to_ipfs
    }

    #[test_only]
    public fun init_for_testing(ctx: &mut TxContext) {
        init(ctx);
    }
}
