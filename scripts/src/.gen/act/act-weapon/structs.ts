import * as reified from "../../_framework/reified";
import {String} from "../../_dependencies/source/0x1/string/structs";
import {UID} from "../../_dependencies/source/0x2/object/structs";
import {PhantomReified, Reified, StructClass, ToField, ToTypeStr, Vector, decodeFromFields, decodeFromFieldsWithTypes, decodeFromJSONField, fieldToJSON, phantom} from "../../_framework/reified";
import {FieldsWithTypes, composeSuiType, compressSuiType} from "../../_framework/util";
import {Upgrade} from "../act-upgrade/structs";
import {PKG_V1} from "../index";
import {bcs, fromB64} from "@mysten/bcs";
import {SuiClient, SuiParsedData} from "@mysten/sui/client";

/* ============================== ACT_WEAPON =============================== */

export function isACT_WEAPON(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::act_weapon::ACT_WEAPON`; }

export interface ACT_WEAPONFields { dummyField: ToField<"bool"> }

export type ACT_WEAPONReified = Reified< ACT_WEAPON, ACT_WEAPONFields >;

export class ACT_WEAPON implements StructClass { static readonly $typeName = `${PKG_V1}::act_weapon::ACT_WEAPON`; static readonly $numTypeParams = 0;

 readonly $typeName = ACT_WEAPON.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::act_weapon::ACT_WEAPON`;

 readonly $typeArgs: [];

 readonly dummyField: ToField<"bool">

 private constructor(typeArgs: [], fields: ACT_WEAPONFields, ) { this.$fullTypeName = composeSuiType( ACT_WEAPON.$typeName, ...typeArgs ) as `${typeof PKG_V1}::act_weapon::ACT_WEAPON`; this.$typeArgs = typeArgs;

 this.dummyField = fields.dummyField; }

 static reified( ): ACT_WEAPONReified { return { typeName: ACT_WEAPON.$typeName, fullTypeName: composeSuiType( ACT_WEAPON.$typeName, ...[] ) as `${typeof PKG_V1}::act_weapon::ACT_WEAPON`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => ACT_WEAPON.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => ACT_WEAPON.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => ACT_WEAPON.fromBcs( data, ), bcs: ACT_WEAPON.bcs, fromJSONField: (field: any) => ACT_WEAPON.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => ACT_WEAPON.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => ACT_WEAPON.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => ACT_WEAPON.fetch( client, id, ), new: ( fields: ACT_WEAPONFields, ) => { return new ACT_WEAPON( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return ACT_WEAPON.reified() }

 static phantom( ): PhantomReified<ToTypeStr<ACT_WEAPON>> { return phantom(ACT_WEAPON.reified( )); } static get p() { return ACT_WEAPON.phantom() }

 static get bcs() { return bcs.struct("ACT_WEAPON", {

 dummy_field: bcs.bool()

}) };

 static fromFields( fields: Record<string, any> ): ACT_WEAPON { return ACT_WEAPON.reified( ).new( { dummyField: decodeFromFields("bool", fields.dummy_field) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): ACT_WEAPON { if (!isACT_WEAPON(item.type)) { throw new Error("not a ACT_WEAPON type");

 }

 return ACT_WEAPON.reified( ).new( { dummyField: decodeFromFieldsWithTypes("bool", item.fields.dummy_field) } ) }

 static fromBcs( data: Uint8Array ): ACT_WEAPON { return ACT_WEAPON.fromFields( ACT_WEAPON.bcs.parse(data) ) }

 toJSONField() { return {

 dummyField: this.dummyField,

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): ACT_WEAPON { return ACT_WEAPON.reified( ).new( { dummyField: decodeFromJSONField("bool", field.dummyField) } ) }

 static fromJSON( json: Record<string, any> ): ACT_WEAPON { if (json.$typeName !== ACT_WEAPON.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return ACT_WEAPON.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): ACT_WEAPON { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isACT_WEAPON(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a ACT_WEAPON object`); } return ACT_WEAPON.fromFieldsWithTypes( content ); }

 static async fetch( client: SuiClient, id: string ): Promise<ACT_WEAPON> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching ACT_WEAPON object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isACT_WEAPON(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a ACT_WEAPON object`); }
 return ACT_WEAPON.fromBcs( fromB64(res.data.bcs.bcsBytes) ); }

 }

/* ============================== Equip =============================== */

export function isEquip(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::act_weapon::Equip`; }

export interface EquipFields { dummyField: ToField<"bool"> }

export type EquipReified = Reified< Equip, EquipFields >;

export class Equip implements StructClass { static readonly $typeName = `${PKG_V1}::act_weapon::Equip`; static readonly $numTypeParams = 0;

 readonly $typeName = Equip.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::act_weapon::Equip`;

 readonly $typeArgs: [];

 readonly dummyField: ToField<"bool">

 private constructor(typeArgs: [], fields: EquipFields, ) { this.$fullTypeName = composeSuiType( Equip.$typeName, ...typeArgs ) as `${typeof PKG_V1}::act_weapon::Equip`; this.$typeArgs = typeArgs;

 this.dummyField = fields.dummyField; }

 static reified( ): EquipReified { return { typeName: Equip.$typeName, fullTypeName: composeSuiType( Equip.$typeName, ...[] ) as `${typeof PKG_V1}::act_weapon::Equip`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => Equip.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => Equip.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => Equip.fromBcs( data, ), bcs: Equip.bcs, fromJSONField: (field: any) => Equip.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => Equip.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => Equip.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => Equip.fetch( client, id, ), new: ( fields: EquipFields, ) => { return new Equip( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return Equip.reified() }

 static phantom( ): PhantomReified<ToTypeStr<Equip>> { return phantom(Equip.reified( )); } static get p() { return Equip.phantom() }

 static get bcs() { return bcs.struct("Equip", {

 dummy_field: bcs.bool()

}) };

 static fromFields( fields: Record<string, any> ): Equip { return Equip.reified( ).new( { dummyField: decodeFromFields("bool", fields.dummy_field) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): Equip { if (!isEquip(item.type)) { throw new Error("not a Equip type");

 }

 return Equip.reified( ).new( { dummyField: decodeFromFieldsWithTypes("bool", item.fields.dummy_field) } ) }

 static fromBcs( data: Uint8Array ): Equip { return Equip.fromFields( Equip.bcs.parse(data) ) }

 toJSONField() { return {

 dummyField: this.dummyField,

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): Equip { return Equip.reified( ).new( { dummyField: decodeFromJSONField("bool", field.dummyField) } ) }

 static fromJSON( json: Record<string, any> ): Equip { if (json.$typeName !== Equip.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return Equip.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): Equip { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isEquip(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a Equip object`); } return Equip.fromFieldsWithTypes( content ); }

 static async fetch( client: SuiClient, id: string ): Promise<Equip> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching Equip object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isEquip(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a Equip object`); }
 return Equip.fromBcs( fromB64(res.data.bcs.bcsBytes) ); }

 }

/* ============================== Weapon =============================== */

export function isWeapon(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::act_weapon::Weapon`; }

export interface WeaponFields { id: ToField<UID>; name: ToField<String>; imageUrl: ToField<String>; imageHash: ToField<String>; modelUrl: ToField<String>; slot: ToField<String>; colourWay: ToField<String>; edition: ToField<String>; manufacturer: ToField<String>; rarity: ToField<String>; hash: ToField<String>; wearRating: ToField<"u64">; killCount: ToField<"u64">; upgrades: ToField<Vector<Upgrade>> }

export type WeaponReified = Reified< Weapon, WeaponFields >;

export class Weapon implements StructClass { static readonly $typeName = `${PKG_V1}::act_weapon::Weapon`; static readonly $numTypeParams = 0;

 readonly $typeName = Weapon.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::act_weapon::Weapon`;

 readonly $typeArgs: [];

 readonly id: ToField<UID>; readonly name: ToField<String>; readonly imageUrl: ToField<String>; readonly imageHash: ToField<String>; readonly modelUrl: ToField<String>; readonly slot: ToField<String>; readonly colourWay: ToField<String>; readonly edition: ToField<String>; readonly manufacturer: ToField<String>; readonly rarity: ToField<String>; readonly hash: ToField<String>; readonly wearRating: ToField<"u64">; readonly killCount: ToField<"u64">; readonly upgrades: ToField<Vector<Upgrade>>

 private constructor(typeArgs: [], fields: WeaponFields, ) { this.$fullTypeName = composeSuiType( Weapon.$typeName, ...typeArgs ) as `${typeof PKG_V1}::act_weapon::Weapon`; this.$typeArgs = typeArgs;

 this.id = fields.id;; this.name = fields.name;; this.imageUrl = fields.imageUrl;; this.imageHash = fields.imageHash;; this.modelUrl = fields.modelUrl;; this.slot = fields.slot;; this.colourWay = fields.colourWay;; this.edition = fields.edition;; this.manufacturer = fields.manufacturer;; this.rarity = fields.rarity;; this.hash = fields.hash;; this.wearRating = fields.wearRating;; this.killCount = fields.killCount;; this.upgrades = fields.upgrades; }

 static reified( ): WeaponReified { return { typeName: Weapon.$typeName, fullTypeName: composeSuiType( Weapon.$typeName, ...[] ) as `${typeof PKG_V1}::act_weapon::Weapon`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => Weapon.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => Weapon.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => Weapon.fromBcs( data, ), bcs: Weapon.bcs, fromJSONField: (field: any) => Weapon.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => Weapon.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => Weapon.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => Weapon.fetch( client, id, ), new: ( fields: WeaponFields, ) => { return new Weapon( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return Weapon.reified() }

 static phantom( ): PhantomReified<ToTypeStr<Weapon>> { return phantom(Weapon.reified( )); } static get p() { return Weapon.phantom() }

 static get bcs() { return bcs.struct("Weapon", {

 id: UID.bcs, name: String.bcs, image_url: String.bcs, image_hash: String.bcs, model_url: String.bcs, slot: String.bcs, colour_way: String.bcs, edition: String.bcs, manufacturer: String.bcs, rarity: String.bcs, hash: String.bcs, wear_rating: bcs.u64(), kill_count: bcs.u64(), upgrades: bcs.vector(Upgrade.bcs)

}) };

 static fromFields( fields: Record<string, any> ): Weapon { return Weapon.reified( ).new( { id: decodeFromFields(UID.reified(), fields.id), name: decodeFromFields(String.reified(), fields.name), imageUrl: decodeFromFields(String.reified(), fields.image_url), imageHash: decodeFromFields(String.reified(), fields.image_hash), modelUrl: decodeFromFields(String.reified(), fields.model_url), slot: decodeFromFields(String.reified(), fields.slot), colourWay: decodeFromFields(String.reified(), fields.colour_way), edition: decodeFromFields(String.reified(), fields.edition), manufacturer: decodeFromFields(String.reified(), fields.manufacturer), rarity: decodeFromFields(String.reified(), fields.rarity), hash: decodeFromFields(String.reified(), fields.hash), wearRating: decodeFromFields("u64", fields.wear_rating), killCount: decodeFromFields("u64", fields.kill_count), upgrades: decodeFromFields(reified.vector(Upgrade.reified()), fields.upgrades) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): Weapon { if (!isWeapon(item.type)) { throw new Error("not a Weapon type");

 }

 return Weapon.reified( ).new( { id: decodeFromFieldsWithTypes(UID.reified(), item.fields.id), name: decodeFromFieldsWithTypes(String.reified(), item.fields.name), imageUrl: decodeFromFieldsWithTypes(String.reified(), item.fields.image_url), imageHash: decodeFromFieldsWithTypes(String.reified(), item.fields.image_hash), modelUrl: decodeFromFieldsWithTypes(String.reified(), item.fields.model_url), slot: decodeFromFieldsWithTypes(String.reified(), item.fields.slot), colourWay: decodeFromFieldsWithTypes(String.reified(), item.fields.colour_way), edition: decodeFromFieldsWithTypes(String.reified(), item.fields.edition), manufacturer: decodeFromFieldsWithTypes(String.reified(), item.fields.manufacturer), rarity: decodeFromFieldsWithTypes(String.reified(), item.fields.rarity), hash: decodeFromFieldsWithTypes(String.reified(), item.fields.hash), wearRating: decodeFromFieldsWithTypes("u64", item.fields.wear_rating), killCount: decodeFromFieldsWithTypes("u64", item.fields.kill_count), upgrades: decodeFromFieldsWithTypes(reified.vector(Upgrade.reified()), item.fields.upgrades) } ) }

 static fromBcs( data: Uint8Array ): Weapon { return Weapon.fromFields( Weapon.bcs.parse(data) ) }

 toJSONField() { return {

 id: this.id,name: this.name,imageUrl: this.imageUrl,imageHash: this.imageHash,modelUrl: this.modelUrl,slot: this.slot,colourWay: this.colourWay,edition: this.edition,manufacturer: this.manufacturer,rarity: this.rarity,hash: this.hash,wearRating: this.wearRating.toString(),killCount: this.killCount.toString(),upgrades: fieldToJSON<Vector<Upgrade>>(`vector<${Upgrade.$typeName}>`, this.upgrades),

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): Weapon { return Weapon.reified( ).new( { id: decodeFromJSONField(UID.reified(), field.id), name: decodeFromJSONField(String.reified(), field.name), imageUrl: decodeFromJSONField(String.reified(), field.imageUrl), imageHash: decodeFromJSONField(String.reified(), field.imageHash), modelUrl: decodeFromJSONField(String.reified(), field.modelUrl), slot: decodeFromJSONField(String.reified(), field.slot), colourWay: decodeFromJSONField(String.reified(), field.colourWay), edition: decodeFromJSONField(String.reified(), field.edition), manufacturer: decodeFromJSONField(String.reified(), field.manufacturer), rarity: decodeFromJSONField(String.reified(), field.rarity), hash: decodeFromJSONField(String.reified(), field.hash), wearRating: decodeFromJSONField("u64", field.wearRating), killCount: decodeFromJSONField("u64", field.killCount), upgrades: decodeFromJSONField(reified.vector(Upgrade.reified()), field.upgrades) } ) }

 static fromJSON( json: Record<string, any> ): Weapon { if (json.$typeName !== Weapon.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return Weapon.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): Weapon { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isWeapon(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a Weapon object`); } return Weapon.fromFieldsWithTypes( content ); }

 static async fetch( client: SuiClient, id: string ): Promise<Weapon> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching Weapon object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isWeapon(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a Weapon object`); }
 return Weapon.fromBcs( fromB64(res.data.bcs.bcsBytes) ); }

 }
