#[test_only]
module act::profile_pictures_tests {

    use std::debug::print;
    use std::string::String;
    
    use sui::{
        test_utils::{assert_eq, destroy},
        test_scenario as ts,
        hash,
    };

    use act::{
        profile_pictures::{Self, ProfilePictures},
        set_up_tests::set_up_admins,
    };

    const OWNER: address = @0xBABE;

    #[test]
    fun test_end_to_end_no_empty() {
        let mut scenario = ts::begin(OWNER);
        profile_pictures::init_for_testing(scenario.ctx());

        scenario.next_tx(OWNER);
        let (access_control, super_admin) = set_up_admins(&mut scenario);
        let mut pfps = scenario.take_shared<ProfilePictures>();
        assert!(pfps.hash_to_ipfs().length() == 0);

        // add a pfp
        let mut helm = vector[];
        helm.append(b"Baha-2000");
        helm.append(b"Helm");
        helm.append(b"Volt");
        let helm_hash = hash::blake2b256(&helm);
        // cb514bf2488716e8b52d2dd7d4d398fc361981ed885c63a085a6f5a03e6ad089
        assert!(vector[
            203, 81, 75, 242, 72, 135, 22, 232, 181, 45, 45, 215, 212, 211, 152, 252,
            54, 25, 129, 237, 136, 92, 99, 160, 133, 166, 245, 160, 62, 106, 208, 137
        ] == helm_hash);

        let mut chestpiece = vector[];
        chestpiece.append(b"Fang MK IV");
        chestpiece.append(b"Chestpiece");
        chestpiece.append(b"Digital Winter");
        let chestpiece_hash = hash::blake2b256(&chestpiece);
        // 00cadb649a8fc5c820c1ea3de178dc96348f73cb54398d30348808cc34038be1
        assert!(vector[
            0, 202, 219, 100, 154, 143, 197, 200, 32, 193, 234, 61, 225, 120, 220, 150,
            52, 143, 115, 203, 84, 57, 141, 48, 52, 136, 8, 204, 52, 3, 139, 225
        ] == chestpiece_hash);

        let mut upper_torso = vector[];
        upper_torso.append(b"Fang MK IV");
        upper_torso.append(b"Upper Torso");
        upper_torso.append(b"Obsidian");
        let upper_torso_hash = hash::blake2b256(&upper_torso);
        // 3ee11c5e2449a9b0778bcd37ac21210e3c83d2569d62c44b5e8f86df992d0354
        assert!(vector[
            62, 225, 28, 94, 36, 73, 169, 176, 119, 139, 205, 55, 172, 33, 33, 14,
            60, 131, 210, 86, 157, 98, 196, 75, 94, 143, 134, 223, 153, 45, 3, 84
        ] == upper_torso_hash);

        pfps.add_pfp(&access_control, &super_admin, helm_hash, chestpiece_hash, upper_torso_hash, b"test".to_string());

        let pfp = pfps.get_pfp(helm_hash, chestpiece_hash, upper_torso_hash);
        assert_eq(pfp, b"test".to_string());

        destroy(pfps);
        destroy(access_control);
        destroy(super_admin);
        scenario.end();
    }

    // TODO: fix this test
    #[test]
    fun test_end_to_end_with_empty() {
        let mut scenario = ts::begin(OWNER);
        profile_pictures::init_for_testing(scenario.ctx());

        scenario.next_tx(OWNER);
        let (access_control, super_admin) = set_up_admins(&mut scenario);
        let mut pfps = scenario.take_shared<ProfilePictures>();
        assert!(pfps.hash_to_ipfs().length() == 0);

        // add a pfp
        let mut helm = vector[];
        helm.append(b"Spectre-09");
        helm.append(b"Helm");
        helm.append(b"Red Damascus");
        let helm_hash = hash::blake2b256(&helm);
        // 8d6c386965350e06e6ffc0103490c17202c832024427fea8ae31616419ec3698
        assert!(vector[
            141, 108, 56, 105, 101, 53, 14, 6, 230, 255, 192, 16, 52, 144, 193, 114,
            2, 200, 50, 32, 36, 66, 127, 234, 138, 227, 22, 22, 65, 158, 195, 105
        ] == helm_hash);

        let mut chestpiece = vector[];
        chestpiece.append(b"Neo-Shogunate");
        chestpiece.append(b"Chestpiece");
        chestpiece.append(b"Viceroy");
        let chestpiece_hash = hash::blake2b256(&chestpiece);
        // 519795687189d31ec00e7f234383dd0ef79867d1aa5f35a89ae91a6826c3d20d
        assert!(vector[
            81, 151, 149, 104, 113, 137, 211, 30, 192, 14, 127, 35, 67, 131, 221, 14,
            247, 152, 103, 209, 170, 95, 53, 168, 154, 233, 26, 104, 38, 195, 210, 13
        ] == chestpiece_hash);

        let upper_torso_hash = vector<u8>[];

        pfps.add_pfp(&access_control, &super_admin, helm_hash, chestpiece_hash, upper_torso_hash, b"test".to_string());

        let pfp = pfps.get_pfp(helm_hash, chestpiece_hash, upper_torso_hash);
        assert_eq(pfp, b"test".to_string());

        destroy(pfps);
        destroy(access_control);
        destroy(super_admin);
        scenario.end();
    }
}