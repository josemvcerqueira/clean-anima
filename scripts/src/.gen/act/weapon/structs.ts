import * as reified from "../../_framework/reified";
import {String} from "../../_dependencies/source/0x1/string/structs";
import {UID} from "../../_dependencies/source/0x2/object/structs";
import {VecMap} from "../../_dependencies/source/0x2/vec-map/structs";
import {PhantomReified, Reified, StructClass, ToField, ToTypeStr, decodeFromFields, decodeFromFieldsWithTypes, decodeFromJSONField, fieldToJSON, phantom} from "../../_framework/reified";
import {FieldsWithTypes, composeSuiType, compressSuiType} from "../../_framework/util";
import {Vector} from "../../_framework/vector";
import {PKG_V1} from "../index";
import {bcs} from "@mysten/sui/bcs";
import {SuiClient, SuiObjectData, SuiParsedData} from "@mysten/sui/client";
import {fromB64} from "@mysten/sui/utils";

/* ============================== Equip =============================== */

export function isEquip(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::weapon::Equip`; }

export interface EquipFields { dummyField: ToField<"bool"> }

export type EquipReified = Reified< Equip, EquipFields >;

export class Equip implements StructClass { __StructClass = true as const;

 static readonly $typeName = `${PKG_V1}::weapon::Equip`; static readonly $numTypeParams = 0; static readonly $isPhantom = [] as const;

 readonly $typeName = Equip.$typeName; readonly $fullTypeName: `${typeof PKG_V1}::weapon::Equip`; readonly $typeArgs: []; readonly $isPhantom = Equip.$isPhantom;

 readonly dummyField: ToField<"bool">

 private constructor(typeArgs: [], fields: EquipFields, ) { this.$fullTypeName = composeSuiType( Equip.$typeName, ...typeArgs ) as `${typeof PKG_V1}::weapon::Equip`; this.$typeArgs = typeArgs;

 this.dummyField = fields.dummyField; }

 static reified( ): EquipReified { return { typeName: Equip.$typeName, fullTypeName: composeSuiType( Equip.$typeName, ...[] ) as `${typeof PKG_V1}::weapon::Equip`, typeArgs: [ ] as [], isPhantom: Equip.$isPhantom, reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => Equip.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => Equip.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => Equip.fromBcs( data, ), bcs: Equip.bcs, fromJSONField: (field: any) => Equip.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => Equip.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => Equip.fromSuiParsedData( content, ), fromSuiObjectData: (content: SuiObjectData) => Equip.fromSuiObjectData( content, ), fetch: async (client: SuiClient, id: string) => Equip.fetch( client, id, ), new: ( fields: EquipFields, ) => { return new Equip( [], fields ) }, kind: "StructClassReified", } }

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

 static fromSuiObjectData( data: SuiObjectData ): Equip { if (data.bcs) { if (data.bcs.dataType !== "moveObject" || !isEquip(data.bcs.type)) { throw new Error(`object at is not a Equip object`); }

 return Equip.fromBcs( fromB64(data.bcs.bcsBytes) ); } if (data.content) { return Equip.fromSuiParsedData( data.content ) } throw new Error( "Both `bcs` and `content` fields are missing from the data. Include `showBcs` or `showContent` in the request." ); }

 static async fetch( client: SuiClient, id: string ): Promise<Equip> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching Equip object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isEquip(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a Equip object`); }

 return Equip.fromSuiObjectData( res.data ); }

 }

/* ============================== WEAPON =============================== */

export function isWEAPON(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::weapon::WEAPON`; }

export interface WEAPONFields { dummyField: ToField<"bool"> }

export type WEAPONReified = Reified< WEAPON, WEAPONFields >;

export class WEAPON implements StructClass { __StructClass = true as const;

 static readonly $typeName = `${PKG_V1}::weapon::WEAPON`; static readonly $numTypeParams = 0; static readonly $isPhantom = [] as const;

 readonly $typeName = WEAPON.$typeName; readonly $fullTypeName: `${typeof PKG_V1}::weapon::WEAPON`; readonly $typeArgs: []; readonly $isPhantom = WEAPON.$isPhantom;

 readonly dummyField: ToField<"bool">

 private constructor(typeArgs: [], fields: WEAPONFields, ) { this.$fullTypeName = composeSuiType( WEAPON.$typeName, ...typeArgs ) as `${typeof PKG_V1}::weapon::WEAPON`; this.$typeArgs = typeArgs;

 this.dummyField = fields.dummyField; }

 static reified( ): WEAPONReified { return { typeName: WEAPON.$typeName, fullTypeName: composeSuiType( WEAPON.$typeName, ...[] ) as `${typeof PKG_V1}::weapon::WEAPON`, typeArgs: [ ] as [], isPhantom: WEAPON.$isPhantom, reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => WEAPON.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => WEAPON.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => WEAPON.fromBcs( data, ), bcs: WEAPON.bcs, fromJSONField: (field: any) => WEAPON.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => WEAPON.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => WEAPON.fromSuiParsedData( content, ), fromSuiObjectData: (content: SuiObjectData) => WEAPON.fromSuiObjectData( content, ), fetch: async (client: SuiClient, id: string) => WEAPON.fetch( client, id, ), new: ( fields: WEAPONFields, ) => { return new WEAPON( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return WEAPON.reified() }

 static phantom( ): PhantomReified<ToTypeStr<WEAPON>> { return phantom(WEAPON.reified( )); } static get p() { return WEAPON.phantom() }

 static get bcs() { return bcs.struct("WEAPON", {

 dummy_field: bcs.bool()

}) };

 static fromFields( fields: Record<string, any> ): WEAPON { return WEAPON.reified( ).new( { dummyField: decodeFromFields("bool", fields.dummy_field) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): WEAPON { if (!isWEAPON(item.type)) { throw new Error("not a WEAPON type");

 }

 return WEAPON.reified( ).new( { dummyField: decodeFromFieldsWithTypes("bool", item.fields.dummy_field) } ) }

 static fromBcs( data: Uint8Array ): WEAPON { return WEAPON.fromFields( WEAPON.bcs.parse(data) ) }

 toJSONField() { return {

 dummyField: this.dummyField,

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): WEAPON { return WEAPON.reified( ).new( { dummyField: decodeFromJSONField("bool", field.dummyField) } ) }

 static fromJSON( json: Record<string, any> ): WEAPON { if (json.$typeName !== WEAPON.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return WEAPON.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): WEAPON { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isWEAPON(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a WEAPON object`); } return WEAPON.fromFieldsWithTypes( content ); }

 static fromSuiObjectData( data: SuiObjectData ): WEAPON { if (data.bcs) { if (data.bcs.dataType !== "moveObject" || !isWEAPON(data.bcs.type)) { throw new Error(`object at is not a WEAPON object`); }

 return WEAPON.fromBcs( fromB64(data.bcs.bcsBytes) ); } if (data.content) { return WEAPON.fromSuiParsedData( data.content ) } throw new Error( "Both `bcs` and `content` fields are missing from the data. Include `showBcs` or `showContent` in the request." ); }

 static async fetch( client: SuiClient, id: string ): Promise<WEAPON> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching WEAPON object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isWEAPON(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a WEAPON object`); }

 return WEAPON.fromSuiObjectData( res.data ); }

 }

/* ============================== Weapon =============================== */

export function isWeapon(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::weapon::Weapon`; }

export interface WeaponFields { id: ToField<UID>; hash: ToField<Vector<"u8">>; name: ToField<String>; imageUrl: ToField<String>; modelUrl: ToField<String>; textureUrl: ToField<String>; slot: ToField<String>; colourWay: ToField<String>; edition: ToField<String>; manufacturer: ToField<String>; rarity: ToField<String>; wearRating: ToField<"u64">; killCount: ToField<"u64">; misc: ToField<VecMap<String, String>> }

export type WeaponReified = Reified< Weapon, WeaponFields >;

export class Weapon implements StructClass { __StructClass = true as const;

 static readonly $typeName = `${PKG_V1}::weapon::Weapon`; static readonly $numTypeParams = 0; static readonly $isPhantom = [] as const;

 readonly $typeName = Weapon.$typeName; readonly $fullTypeName: `${typeof PKG_V1}::weapon::Weapon`; readonly $typeArgs: []; readonly $isPhantom = Weapon.$isPhantom;

 readonly id: ToField<UID>; readonly hash: ToField<Vector<"u8">>; readonly name: ToField<String>; readonly imageUrl: ToField<String>; readonly modelUrl: ToField<String>; readonly textureUrl: ToField<String>; readonly slot: ToField<String>; readonly colourWay: ToField<String>; readonly edition: ToField<String>; readonly manufacturer: ToField<String>; readonly rarity: ToField<String>; readonly wearRating: ToField<"u64">; readonly killCount: ToField<"u64">; readonly misc: ToField<VecMap<String, String>>

 private constructor(typeArgs: [], fields: WeaponFields, ) { this.$fullTypeName = composeSuiType( Weapon.$typeName, ...typeArgs ) as `${typeof PKG_V1}::weapon::Weapon`; this.$typeArgs = typeArgs;

 this.id = fields.id;; this.hash = fields.hash;; this.name = fields.name;; this.imageUrl = fields.imageUrl;; this.modelUrl = fields.modelUrl;; this.textureUrl = fields.textureUrl;; this.slot = fields.slot;; this.colourWay = fields.colourWay;; this.edition = fields.edition;; this.manufacturer = fields.manufacturer;; this.rarity = fields.rarity;; this.wearRating = fields.wearRating;; this.killCount = fields.killCount;; this.misc = fields.misc; }

 static reified( ): WeaponReified { return { typeName: Weapon.$typeName, fullTypeName: composeSuiType( Weapon.$typeName, ...[] ) as `${typeof PKG_V1}::weapon::Weapon`, typeArgs: [ ] as [], isPhantom: Weapon.$isPhantom, reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => Weapon.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => Weapon.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => Weapon.fromBcs( data, ), bcs: Weapon.bcs, fromJSONField: (field: any) => Weapon.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => Weapon.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => Weapon.fromSuiParsedData( content, ), fromSuiObjectData: (content: SuiObjectData) => Weapon.fromSuiObjectData( content, ), fetch: async (client: SuiClient, id: string) => Weapon.fetch( client, id, ), new: ( fields: WeaponFields, ) => { return new Weapon( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return Weapon.reified() }

 static phantom( ): PhantomReified<ToTypeStr<Weapon>> { return phantom(Weapon.reified( )); } static get p() { return Weapon.phantom() }

 static get bcs() { return bcs.struct("Weapon", {

 id: UID.bcs, hash: bcs.vector(bcs.u8()), name: String.bcs, image_url: String.bcs, model_url: String.bcs, texture_url: String.bcs, slot: String.bcs, colour_way: String.bcs, edition: String.bcs, manufacturer: String.bcs, rarity: String.bcs, wear_rating: bcs.u64(), kill_count: bcs.u64(), misc: VecMap.bcs(String.bcs, String.bcs)

}) };

 static fromFields( fields: Record<string, any> ): Weapon { return Weapon.reified( ).new( { id: decodeFromFields(UID.reified(), fields.id), hash: decodeFromFields(reified.vector("u8"), fields.hash), name: decodeFromFields(String.reified(), fields.name), imageUrl: decodeFromFields(String.reified(), fields.image_url), modelUrl: decodeFromFields(String.reified(), fields.model_url), textureUrl: decodeFromFields(String.reified(), fields.texture_url), slot: decodeFromFields(String.reified(), fields.slot), colourWay: decodeFromFields(String.reified(), fields.colour_way), edition: decodeFromFields(String.reified(), fields.edition), manufacturer: decodeFromFields(String.reified(), fields.manufacturer), rarity: decodeFromFields(String.reified(), fields.rarity), wearRating: decodeFromFields("u64", fields.wear_rating), killCount: decodeFromFields("u64", fields.kill_count), misc: decodeFromFields(VecMap.reified(String.reified(), String.reified()), fields.misc) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): Weapon { if (!isWeapon(item.type)) { throw new Error("not a Weapon type");

 }

 return Weapon.reified( ).new( { id: decodeFromFieldsWithTypes(UID.reified(), item.fields.id), hash: decodeFromFieldsWithTypes(reified.vector("u8"), item.fields.hash), name: decodeFromFieldsWithTypes(String.reified(), item.fields.name), imageUrl: decodeFromFieldsWithTypes(String.reified(), item.fields.image_url), modelUrl: decodeFromFieldsWithTypes(String.reified(), item.fields.model_url), textureUrl: decodeFromFieldsWithTypes(String.reified(), item.fields.texture_url), slot: decodeFromFieldsWithTypes(String.reified(), item.fields.slot), colourWay: decodeFromFieldsWithTypes(String.reified(), item.fields.colour_way), edition: decodeFromFieldsWithTypes(String.reified(), item.fields.edition), manufacturer: decodeFromFieldsWithTypes(String.reified(), item.fields.manufacturer), rarity: decodeFromFieldsWithTypes(String.reified(), item.fields.rarity), wearRating: decodeFromFieldsWithTypes("u64", item.fields.wear_rating), killCount: decodeFromFieldsWithTypes("u64", item.fields.kill_count), misc: decodeFromFieldsWithTypes(VecMap.reified(String.reified(), String.reified()), item.fields.misc) } ) }

 static fromBcs( data: Uint8Array ): Weapon { return Weapon.fromFields( Weapon.bcs.parse(data) ) }

 toJSONField() { return {

 id: this.id,hash: fieldToJSON<Vector<"u8">>(`vector<u8>`, this.hash),name: this.name,imageUrl: this.imageUrl,modelUrl: this.modelUrl,textureUrl: this.textureUrl,slot: this.slot,colourWay: this.colourWay,edition: this.edition,manufacturer: this.manufacturer,rarity: this.rarity,wearRating: this.wearRating.toString(),killCount: this.killCount.toString(),misc: this.misc.toJSONField(),

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): Weapon { return Weapon.reified( ).new( { id: decodeFromJSONField(UID.reified(), field.id), hash: decodeFromJSONField(reified.vector("u8"), field.hash), name: decodeFromJSONField(String.reified(), field.name), imageUrl: decodeFromJSONField(String.reified(), field.imageUrl), modelUrl: decodeFromJSONField(String.reified(), field.modelUrl), textureUrl: decodeFromJSONField(String.reified(), field.textureUrl), slot: decodeFromJSONField(String.reified(), field.slot), colourWay: decodeFromJSONField(String.reified(), field.colourWay), edition: decodeFromJSONField(String.reified(), field.edition), manufacturer: decodeFromJSONField(String.reified(), field.manufacturer), rarity: decodeFromJSONField(String.reified(), field.rarity), wearRating: decodeFromJSONField("u64", field.wearRating), killCount: decodeFromJSONField("u64", field.killCount), misc: decodeFromJSONField(VecMap.reified(String.reified(), String.reified()), field.misc) } ) }

 static fromJSON( json: Record<string, any> ): Weapon { if (json.$typeName !== Weapon.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return Weapon.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): Weapon { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isWeapon(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a Weapon object`); } return Weapon.fromFieldsWithTypes( content ); }

 static fromSuiObjectData( data: SuiObjectData ): Weapon { if (data.bcs) { if (data.bcs.dataType !== "moveObject" || !isWeapon(data.bcs.type)) { throw new Error(`object at is not a Weapon object`); }

 return Weapon.fromBcs( fromB64(data.bcs.bcsBytes) ); } if (data.content) { return Weapon.fromSuiParsedData( data.content ) } throw new Error( "Both `bcs` and `content` fields are missing from the data. Include `showBcs` or `showContent` in the request." ); }

 static async fetch( client: SuiClient, id: string ): Promise<Weapon> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching Weapon object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isWeapon(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a Weapon object`); }

 return Weapon.fromSuiObjectData( res.data ); }

 }
