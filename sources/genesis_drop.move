// module act::act_genesis_drop {
//     // === Imports ===

//     use std::string::{utf8, String};
//     use sui::{
//         random::{Self, Random},
//         package, 
//         display, 
//         clock::Clock,
//         table_vec::TableVec
//     };
//     use act::{
//         act_factory::Item,
//         act_shop::{Self, Shop, Helm},
//         act_avatar::{Self, Avatar, AvatarRegistry},
//         act_cosmetic::{Self, Cosmetic}
//     };


//     // === Errors ===

//     const EAlreadyMinted: u64 = 0;

//     // === Constants ===

//     const NUM_OF_GENESIS_PASS: u64 = 6_000;
//     const WEAR_RATING_MAX: u64 = 1_000_000_000;

//     // === Structs ===

//     public struct ACT_GENESIS_DROP has drop {}

//     public struct ActGenesisPass has key {
//         id: UID,
//         name: String,
//         description: String,
//         image_url: String, 
//         project_url: String,
//         creator: String
//     }

//     /*
//     * @description Because the Avatar is a key only object and the Random object has to be used in entry functions, we need to first mint all items then mint the avatar and equip all items.
//     */
//     public struct GenesisItems has key {
//         id: UID,
//         helm: Option<Cosmetic>,
//         chestpiece: Option<Cosmetic>,
//         upper_torso: Option<Cosmetic>,
//         right_pauldron: Option<Cosmetic>,
//         left_pauldron: Option<Cosmetic>,
//         right_arm: Option<Cosmetic>,
//         left_arm: Option<Cosmetic>,
//         right_glove: Option<Cosmetic>,
//         left_glove: Option<Cosmetic>,
//         right_bracer: Option<Cosmetic>,
//         left_bracer: Option<Cosmetic>,
//         legs: Option<Cosmetic>,
//         shins: Option<Cosmetic>,
//         boots: Option<Cosmetic>,
//         accessory: Option<Cosmetic>,
//     }

//     // === Method Aliases ===

//     // === Public-Mutative Functions ===

//     #[allow(lint(share_owned))]
//     fun init(otw: ACT_GENESIS_DROP, ctx: &mut TxContext) {
//         // create Display
//         let keys = vector[
//             utf8(b"name"),
//             utf8(b"description"),
//             utf8(b"image_url"),
//             utf8(b"project_url"),
//             utf8(b"creator"),
//         ];
//         let values = vector[
//             utf8(b"ACT Cosmetic: {name}"),
//             utf8(b"ACT is a fast-paced, high-skill multiplayer FPS"),
//             utf8(b"ipfs://{image_url}"),
//             utf8(b"https://animalabs.io"), // to change with ACT game page
//             utf8(b"Anima Labs"),
//         ];

//         let publisher = package::claim(otw, ctx);
//         let mut display = display::new_with_fields<ActGenesisPass>(
//             &publisher, keys, values, ctx
//         );
//         display.update_version();
//         transfer::public_transfer(display, ctx.sender());
//         transfer::public_transfer(publisher, ctx.sender());

//         let mut i = 0;

//         while(NUM_OF_GENESIS_PASS > i) {
//             let pass = ActGenesisPass {
//                 id: object::new(ctx),
//                 // To FullFill
//                 name: utf8(b""),
//                 description: utf8(b""),
//                 image_url: utf8(b""), 
//                 project_url: utf8(b""),
//                 creator: utf8(b"")                
//             };

//             transfer::transfer(pass, ctx.sender());

//             i = i + 1;
//         };
//     }

//     public fun mint(
//         registry: &mut AvatarRegistry,
//         clock: &Clock,
//         pass: ActGenesisPass,
//         alias: String,
//         username: String,
//         ctx: &mut TxContext
//     ) {
//         let ActGenesisPass { id, name: _, description: _, image_url: _, project_url: _, creator:_ } = pass;
//         id.delete();

//         let items = GenesisItems {
//             id: object::new(ctx),
//             helm: option::none(),
//             chestpiece: option::none(),
//             upper_torso: option::none(),
//             right_pauldron: option::none(),
//             left_pauldron: option::none(),
//             right_arm: option::none(),
//             left_arm: option::none(),
//             right_glove: option::none(),
//             left_glove: option::none(),
//             right_bracer: option::none(),
//             left_bracer: option::none(),
//             legs: option::none(),
//             shins: option::none(),
//             boots: option::none(),
//             accessory: option::none(),            
//         };

//         transfer::transfer(items, ctx.sender());
//     }

//     // @dev The Random shared object has to be used in non-public functions to avoid attacks
//     entry fun mint_helm(
//         self: &mut GenesisItems,
//         random: &Random,
//         shop: &Shop<Helm, TableVec<Item>>,
//         ctx: &mut TxContext
//     ) {
//         assert!(self.helm.is_none(), EAlreadyMinted);

//         let mut gen = random.new_generator(ctx);

//         let helms = shop.items();
//         let index = gen.generate_u64_in_range(0, helms.length());
//         let wear_rating = gen.generate_u64_in_range(0, WEAR_RATING_MAX);

//         let item = helms.borrow(index);
        
//         self.helm.fill(
//             act_cosmetic::mint(
//                 item.name(),
//                 utf8(b""),
//                 utf8(b""),
//                 utf8(b""),
//                 utf8(b"Helm"),
//                 item.colour_way(),
//                 utf8(b"Genesis"),
//                 item.manufacturer(),
//                 utf8(b""),
//                 utf8(b""),
//                 wear_rating,
//                 ctx
//             )
//         );
//     }

//     // === Public-View Functions ===

//     // === Admin Functions ===

//     // === Public-Package Functions ===

//     // === Private Functions ===

//     // === Test Functions ===
// }

//         // registry: &mut AvatarRegistry, 
//         // alias: String,
//         // username: String,
//         // image_url: String,
//         // image_hash: String,
//         // model_url: String,
//         // avatar_url: String,
//         // avatar_hash: String,
//         // edition: String,
//         // clock: &Clock,
//         // ctx: &mut TxContext