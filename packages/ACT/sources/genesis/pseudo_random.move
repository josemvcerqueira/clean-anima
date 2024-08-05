module act::pseuso_random {
    // === Imports ===
    use std::hash;
    use sui::{
        bcs,
        clock::Clock
    };

    // === Constants ===

    // === Structs ===

    // === Public mutative functions ===

    // === Public view functions === 

    // === Admin functions ===

    // === Package functions ===

    public(package) fun rng(min: u64, max: u64, clock: &Clock, ctx: &mut TxContext): u64 {
        assert!(max >= min);
        let value = from_seed(seed(clock ,ctx));

        value % (max - min) + min
    }

    // === Private functions ===

    fun from_seed(seed: vector<u8>): u64 {
        assert!(vector::length(&seed) >= 8);
        bcs::peel_u64(&mut bcs::new(seed))
    }

    public fun seed(clock: &Clock, ctx: &mut TxContext): vector<u8> {
        let mut raw_seed = raw_seed(ctx);

        let timestamp_bytes = bcs::to_bytes(&clock.timestamp_ms());
        vector::append(&mut raw_seed, timestamp_bytes);

        hash::sha3_256(raw_seed)
    }

    fun raw_seed(ctx: &mut TxContext): vector<u8> {
        let sender_bytes = bcs::to_bytes(&ctx.sender());

        let epoch_bytes = bcs::to_bytes(&ctx.epoch());

        let id = object::new(ctx);
        let id_bytes = id.to_bytes();
        id.delete();

        let mut raw_seed = vector[];
        raw_seed.append(id_bytes);
        raw_seed.append(epoch_bytes);
        raw_seed.append(sender_bytes);

        raw_seed
    }
}