#[test_only]
module act::profile_pictures_tests {
    
    use sui::{
        test_utils::{assert_eq, destroy},
        test_scenario as ts,
        hash,
    };

    use act::{
        profile_pictures::{Self, cosmetic_to_pfp_hash, ProfilePictures},
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
        assert_eq(pfps.hash_to_ipfs().length() , 0);

        // add a pfp
        let mut helm = vector[];
        helm.append(b"Baha-2000");
        helm.append(b"Helm");
        helm.append(b"Volt");
        let helm_hash = hash::blake2b256(&helm);

        assert_eq(b"cb514bf2488716e8b52d2dd7d4d398fc361981ed885c63a085a6f5a03e6ad089", helm_hash);

        let mut chestpiece = vector[];
        chestpiece.append(b"Fang MK IV");
        chestpiece.append(b"Chestpiece");
        chestpiece.append(b"Digital Winter");
        let chestpiece_hash = hash::blake2b256(&chestpiece);
 
        assert_eq(b"00cadb649a8fc5c820c1ea3de178dc96348f73cb54398d30348808cc34038be1", chestpiece_hash);

        let mut upper_torso = vector[];
        upper_torso.append(b"Fang MK IV");
        upper_torso.append(b"Upper Torso");
        upper_torso.append(b"Obsidian");
        let upper_torso_hash = hash::blake2b256(&upper_torso);

        assert_eq(b"3ee11c5e2449a9b0778bcd37ac21210e3c83d2569d62c44b5e8f86df992d0354", upper_torso_hash);

        pfps.add(&access_control, &super_admin, cosmetic_to_pfp_hash(helm_hash, chestpiece_hash, upper_torso_hash), b"test".to_string());

        let pfp = pfps.get(helm_hash, chestpiece_hash, upper_torso_hash);
        assert_eq(pfp, b"test".to_string());

        assert_eq(pfps.contains(helm_hash, chestpiece_hash, upper_torso_hash), true);

        pfps.remove(&access_control, &super_admin, cosmetic_to_pfp_hash(helm_hash, chestpiece_hash, upper_torso_hash));

       assert_eq(pfps.contains(helm_hash, chestpiece_hash, upper_torso_hash), false);

        destroy(pfps);
        destroy(access_control);
        destroy(super_admin);
        scenario.end();
    }

    #[test]
    fun test_end_to_end_with_empty() {
        let mut scenario = ts::begin(OWNER);
        profile_pictures::init_for_testing(scenario.ctx());

        scenario.next_tx(OWNER);
        
        let (access_control, super_admin) = set_up_admins(&mut scenario);
        let mut pfps = scenario.take_shared<ProfilePictures>();
        assert_eq(pfps.hash_to_ipfs().length(), 0);

        // add a pfp
        let mut helm = vector[];
        helm.append(b"Spectre-09");
        helm.append(b"Helm");
        helm.append(b"Red Damascus");
        let helm_hash = hash::blake2b256(&helm);
        assert_eq(x"8d6c386965350e06e6ffc0103490c17202c832024427fea8ae31616419ec3698", helm_hash);

        let mut chestpiece = vector[];
        chestpiece.append(b"Neo-Shogunate");
        chestpiece.append(b"Chestpiece");
        chestpiece.append(b"Viceroy");
        let chestpiece_hash = hash::blake2b256(&chestpiece);

        assert_eq(x"519795687189d31ec00e7f234383dd0ef79867d1aa5f35a89ae91a6826c3d20d", chestpiece_hash);

        let upper_torso_hash = vector<u8>[];

        pfps.add(&access_control, &super_admin, cosmetic_to_pfp_hash(helm_hash, chestpiece_hash, upper_torso_hash), b"test".to_string());

        let pfp = pfps.get(helm_hash, chestpiece_hash, upper_torso_hash);
        assert_eq(pfp, b"test".to_string());

        destroy(pfps);
        destroy(access_control);
        destroy(super_admin);
        scenario.end();
    }

    #[test]
    #[expected_failure(abort_code = profile_pictures::EProfilePictureNotFound)] 
    fun test_get_error_profile_picture_not_found() {
        let mut scenario = ts::begin(OWNER);
        profile_pictures::init_for_testing(scenario.ctx());

        scenario.next_tx(OWNER);
        
        let (access_control, super_admin) = set_up_admins(&mut scenario);
        let pfps = scenario.take_shared<ProfilePictures>();

        // add a pfp
        let mut helm = vector[];
        helm.append(b"Spectre-09");
        helm.append(b"Helm");
        helm.append(b"Red Damascus");
        let helm_hash = hash::blake2b256(&helm);


        let mut chestpiece = vector[];
        chestpiece.append(b"Neo-Shogunate");
        chestpiece.append(b"Chestpiece");
        chestpiece.append(b"Viceroy");
        let chestpiece_hash = hash::blake2b256(&chestpiece);

        let upper_torso_hash = vector<u8>[];

        pfps.get(helm_hash, chestpiece_hash, upper_torso_hash);

        destroy(pfps);
        destroy(access_control);
        destroy(super_admin);
        scenario.end();
    }
}