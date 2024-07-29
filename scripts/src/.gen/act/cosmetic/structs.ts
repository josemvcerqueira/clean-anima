import * as reified from "../../_framework/reified";
import {String} from "../../_dependencies/source/0x1/string/structs";
import {UID} from "../../_dependencies/source/0x2/object/structs";
import {VecMap} from "../../_dependencies/source/0x2/vec-map/structs";
import {PhantomReified, Reified, StructClass, ToField, ToTypeStr, Vector, decodeFromFields, decodeFromFieldsWithTypes, decodeFromJSONField, fieldToJSON, phantom} from "../../_framework/reified";
import {FieldsWithTypes, composeSuiType, compressSuiType} from "../../_framework/util";
import {PKG_V1} from "../index";
import {Upgrade} from "../upgrade/structs";
import {bcs, fromB64} from "@mysten/bcs";
import {SuiClient, SuiParsedData} from "@mysten/sui/client";

/* ============================== Equip =============================== */

export function isEquip(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::cosmetic::Equip`; }

export interface EquipFields { dummyField: ToField<"bool"> }

export type EquipReified = Reified< Equip, EquipFields >;

export class Equip implements StructClass { static readonly $typeName = `${PKG_V1}::cosmetic::Equip`; static readonly $numTypeParams = 0;

 readonly $typeName = Equip.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::cosmetic::Equip`;

 readonly $typeArgs: [];

 readonly dummyField: ToField<"bool">

 private constructor(typeArgs: [], fields: EquipFields, ) { this.$fullTypeName = composeSuiType( Equip.$typeName, ...typeArgs ) as `${typeof PKG_V1}::cosmetic::Equip`; this.$typeArgs = typeArgs;

 this.dummyField = fields.dummyField; }

 static reified( ): EquipReified { return { typeName: Equip.$typeName, fullTypeName: composeSuiType( Equip.$typeName, ...[] ) as `${typeof PKG_V1}::cosmetic::Equip`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => Equip.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => Equip.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => Equip.fromBcs( data, ), bcs: Equip.bcs, fromJSONField: (field: any) => Equip.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => Equip.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => Equip.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => Equip.fetch( client, id, ), new: ( fields: EquipFields, ) => { return new Equip( [], fields ) }, kind: "StructClassReified", } }

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

/* ============================== COSMETIC =============================== */

export function isCOSMETIC(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::cosmetic::COSMETIC`; }

export interface COSMETICFields { dummyField: ToField<"bool"> }

export type COSMETICReified = Reified< COSMETIC, COSMETICFields >;

export class COSMETIC implements StructClass { static readonly $typeName = `${PKG_V1}::cosmetic::COSMETIC`; static readonly $numTypeParams = 0;

 readonly $typeName = COSMETIC.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::cosmetic::COSMETIC`;

 readonly $typeArgs: [];

 readonly dummyField: ToField<"bool">

 private constructor(typeArgs: [], fields: COSMETICFields, ) { this.$fullTypeName = composeSuiType( COSMETIC.$typeName, ...typeArgs ) as `${typeof PKG_V1}::cosmetic::COSMETIC`; this.$typeArgs = typeArgs;

 this.dummyField = fields.dummyField; }

 static reified( ): COSMETICReified { return { typeName: COSMETIC.$typeName, fullTypeName: composeSuiType( COSMETIC.$typeName, ...[] ) as `${typeof PKG_V1}::cosmetic::COSMETIC`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => COSMETIC.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => COSMETIC.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => COSMETIC.fromBcs( data, ), bcs: COSMETIC.bcs, fromJSONField: (field: any) => COSMETIC.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => COSMETIC.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => COSMETIC.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => COSMETIC.fetch( client, id, ), new: ( fields: COSMETICFields, ) => { return new COSMETIC( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return COSMETIC.reified() }

 static phantom( ): PhantomReified<ToTypeStr<COSMETIC>> { return phantom(COSMETIC.reified( )); } static get p() { return COSMETIC.phantom() }

 static get bcs() { return bcs.struct("COSMETIC", {

 dummy_field: bcs.bool()

}) };

 static fromFields( fields: Record<string, any> ): COSMETIC { return COSMETIC.reified( ).new( { dummyField: decodeFromFields("bool", fields.dummy_field) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): COSMETIC { if (!isCOSMETIC(item.type)) { throw new Error("not a COSMETIC type");

 }

 return COSMETIC.reified( ).new( { dummyField: decodeFromFieldsWithTypes("bool", item.fields.dummy_field) } ) }

 static fromBcs( data: Uint8Array ): COSMETIC { return COSMETIC.fromFields( COSMETIC.bcs.parse(data) ) }

 toJSONField() { return {

 dummyField: this.dummyField,

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): COSMETIC { return COSMETIC.reified( ).new( { dummyField: decodeFromJSONField("bool", field.dummyField) } ) }

 static fromJSON( json: Record<string, any> ): COSMETIC { if (json.$typeName !== COSMETIC.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return COSMETIC.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): COSMETIC { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isCOSMETIC(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a COSMETIC object`); } return COSMETIC.fromFieldsWithTypes( content ); }

 static async fetch( client: SuiClient, id: string ): Promise<COSMETIC> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching COSMETIC object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isCOSMETIC(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a COSMETIC object`); }
 return COSMETIC.fromBcs( fromB64(res.data.bcs.bcsBytes) ); }

 }

/* ============================== Cosmetic =============================== */

export function isCosmetic(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::cosmetic::Cosmetic`; }

export interface CosmeticFields { id: ToField<UID>; hash: ToField<Vector<"u8">>; name: ToField<String>; imageUrl: ToField<String>; modelUrl: ToField<String>; textureUrl: ToField<String>; type: ToField<String>; colourWay: ToField<String>; edition: ToField<String>; manufacturer: ToField<String>; rarity: ToField<String>; wearRating: ToField<"u64">; upgrades: ToField<Vector<Upgrade>>; misc: ToField<VecMap<String, String>> }

export type CosmeticReified = Reified< Cosmetic, CosmeticFields >;

export class Cosmetic implements StructClass { static readonly $typeName = `${PKG_V1}::cosmetic::Cosmetic`; static readonly $numTypeParams = 0;

 readonly $typeName = Cosmetic.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::cosmetic::Cosmetic`;

 readonly $typeArgs: [];

 readonly id: ToField<UID>; readonly hash: ToField<Vector<"u8">>; readonly name: ToField<String>; readonly imageUrl: ToField<String>; readonly modelUrl: ToField<String>; readonly textureUrl: ToField<String>; readonly type: ToField<String>; readonly colourWay: ToField<String>; readonly edition: ToField<String>; readonly manufacturer: ToField<String>; readonly rarity: ToField<String>; readonly wearRating: ToField<"u64">; readonly upgrades: ToField<Vector<Upgrade>>; readonly misc: ToField<VecMap<String, String>>

 private constructor(typeArgs: [], fields: CosmeticFields, ) { this.$fullTypeName = composeSuiType( Cosmetic.$typeName, ...typeArgs ) as `${typeof PKG_V1}::cosmetic::Cosmetic`; this.$typeArgs = typeArgs;

 this.id = fields.id;; this.hash = fields.hash;; this.name = fields.name;; this.imageUrl = fields.imageUrl;; this.modelUrl = fields.modelUrl;; this.textureUrl = fields.textureUrl;; this.type = fields.type;; this.colourWay = fields.colourWay;; this.edition = fields.edition;; this.manufacturer = fields.manufacturer;; this.rarity = fields.rarity;; this.wearRating = fields.wearRating;; this.upgrades = fields.upgrades;; this.misc = fields.misc; }

 static reified( ): CosmeticReified { return { typeName: Cosmetic.$typeName, fullTypeName: composeSuiType( Cosmetic.$typeName, ...[] ) as `${typeof PKG_V1}::cosmetic::Cosmetic`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => Cosmetic.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => Cosmetic.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => Cosmetic.fromBcs( data, ), bcs: Cosmetic.bcs, fromJSONField: (field: any) => Cosmetic.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => Cosmetic.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => Cosmetic.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => Cosmetic.fetch( client, id, ), new: ( fields: CosmeticFields, ) => { return new Cosmetic( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return Cosmetic.reified() }

 static phantom( ): PhantomReified<ToTypeStr<Cosmetic>> { return phantom(Cosmetic.reified( )); } static get p() { return Cosmetic.phantom() }

 static get bcs() { return bcs.struct("Cosmetic", {

 id: UID.bcs, hash: bcs.vector(bcs.u8()), name: String.bcs, image_url: String.bcs, model_url: String.bcs, texture_url: String.bcs, type: String.bcs, colour_way: String.bcs, edition: String.bcs, manufacturer: String.bcs, rarity: String.bcs, wear_rating: bcs.u64(), upgrades: bcs.vector(Upgrade.bcs), misc: VecMap.bcs(String.bcs, String.bcs)

}) };

 static fromFields( fields: Record<string, any> ): Cosmetic { return Cosmetic.reified( ).new( { id: decodeFromFields(UID.reified(), fields.id), hash: decodeFromFields(reified.vector("u8"), fields.hash), name: decodeFromFields(String.reified(), fields.name), imageUrl: decodeFromFields(String.reified(), fields.image_url), modelUrl: decodeFromFields(String.reified(), fields.model_url), textureUrl: decodeFromFields(String.reified(), fields.texture_url), type: decodeFromFields(String.reified(), fields.type), colourWay: decodeFromFields(String.reified(), fields.colour_way), edition: decodeFromFields(String.reified(), fields.edition), manufacturer: decodeFromFields(String.reified(), fields.manufacturer), rarity: decodeFromFields(String.reified(), fields.rarity), wearRating: decodeFromFields("u64", fields.wear_rating), upgrades: decodeFromFields(reified.vector(Upgrade.reified()), fields.upgrades), misc: decodeFromFields(VecMap.reified(String.reified(), String.reified()), fields.misc) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): Cosmetic { if (!isCosmetic(item.type)) { throw new Error("not a Cosmetic type");

 }

 return Cosmetic.reified( ).new( { id: decodeFromFieldsWithTypes(UID.reified(), item.fields.id), hash: decodeFromFieldsWithTypes(reified.vector("u8"), item.fields.hash), name: decodeFromFieldsWithTypes(String.reified(), item.fields.name), imageUrl: decodeFromFieldsWithTypes(String.reified(), item.fields.image_url), modelUrl: decodeFromFieldsWithTypes(String.reified(), item.fields.model_url), textureUrl: decodeFromFieldsWithTypes(String.reified(), item.fields.texture_url), type: decodeFromFieldsWithTypes(String.reified(), item.fields.type), colourWay: decodeFromFieldsWithTypes(String.reified(), item.fields.colour_way), edition: decodeFromFieldsWithTypes(String.reified(), item.fields.edition), manufacturer: decodeFromFieldsWithTypes(String.reified(), item.fields.manufacturer), rarity: decodeFromFieldsWithTypes(String.reified(), item.fields.rarity), wearRating: decodeFromFieldsWithTypes("u64", item.fields.wear_rating), upgrades: decodeFromFieldsWithTypes(reified.vector(Upgrade.reified()), item.fields.upgrades), misc: decodeFromFieldsWithTypes(VecMap.reified(String.reified(), String.reified()), item.fields.misc) } ) }

 static fromBcs( data: Uint8Array ): Cosmetic { return Cosmetic.fromFields( Cosmetic.bcs.parse(data) ) }

 toJSONField() { return {

 id: this.id,hash: fieldToJSON<Vector<"u8">>(`vector<u8>`, this.hash),name: this.name,imageUrl: this.imageUrl,modelUrl: this.modelUrl,textureUrl: this.textureUrl,type: this.type,colourWay: this.colourWay,edition: this.edition,manufacturer: this.manufacturer,rarity: this.rarity,wearRating: this.wearRating.toString(),upgrades: fieldToJSON<Vector<Upgrade>>(`vector<${Upgrade.$typeName}>`, this.upgrades),misc: this.misc.toJSONField(),

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): Cosmetic { return Cosmetic.reified( ).new( { id: decodeFromJSONField(UID.reified(), field.id), hash: decodeFromJSONField(reified.vector("u8"), field.hash), name: decodeFromJSONField(String.reified(), field.name), imageUrl: decodeFromJSONField(String.reified(), field.imageUrl), modelUrl: decodeFromJSONField(String.reified(), field.modelUrl), textureUrl: decodeFromJSONField(String.reified(), field.textureUrl), type: decodeFromJSONField(String.reified(), field.type), colourWay: decodeFromJSONField(String.reified(), field.colourWay), edition: decodeFromJSONField(String.reified(), field.edition), manufacturer: decodeFromJSONField(String.reified(), field.manufacturer), rarity: decodeFromJSONField(String.reified(), field.rarity), wearRating: decodeFromJSONField("u64", field.wearRating), upgrades: decodeFromJSONField(reified.vector(Upgrade.reified()), field.upgrades), misc: decodeFromJSONField(VecMap.reified(String.reified(), String.reified()), field.misc) } ) }

 static fromJSON( json: Record<string, any> ): Cosmetic { if (json.$typeName !== Cosmetic.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return Cosmetic.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): Cosmetic { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isCosmetic(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a Cosmetic object`); } return Cosmetic.fromFieldsWithTypes( content ); }

 static async fetch( client: SuiClient, id: string ): Promise<Cosmetic> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching Cosmetic object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isCosmetic(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a Cosmetic object`); }
 return Cosmetic.fromBcs( fromB64(res.data.bcs.bcsBytes) ); }

 }
