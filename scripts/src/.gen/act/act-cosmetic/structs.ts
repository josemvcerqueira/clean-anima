import * as reified from "../../_framework/reified";
import {String} from "../../_dependencies/source/0x1/string/structs";
import {UID} from "../../_dependencies/source/0x2/object/structs";
import {PhantomReified, Reified, StructClass, ToField, ToTypeStr, Vector, decodeFromFields, decodeFromFieldsWithTypes, decodeFromJSONField, fieldToJSON, phantom} from "../../_framework/reified";
import {FieldsWithTypes, composeSuiType, compressSuiType} from "../../_framework/util";
import {Upgrade} from "../act-upgrade/structs";
import {PKG_V1} from "../index";
import {bcs, fromB64} from "@mysten/bcs";
import {SuiClient, SuiParsedData} from "@mysten/sui/client";

/* ============================== Equip =============================== */

export function isEquip(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::act_cosmetic::Equip`; }

export interface EquipFields { dummyField: ToField<"bool"> }

export type EquipReified = Reified< Equip, EquipFields >;

export class Equip implements StructClass { static readonly $typeName = `${PKG_V1}::act_cosmetic::Equip`; static readonly $numTypeParams = 0;

 readonly $typeName = Equip.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::act_cosmetic::Equip`;

 readonly $typeArgs: [];

 readonly dummyField: ToField<"bool">

 private constructor(typeArgs: [], fields: EquipFields, ) { this.$fullTypeName = composeSuiType( Equip.$typeName, ...typeArgs ) as `${typeof PKG_V1}::act_cosmetic::Equip`; this.$typeArgs = typeArgs;

 this.dummyField = fields.dummyField; }

 static reified( ): EquipReified { return { typeName: Equip.$typeName, fullTypeName: composeSuiType( Equip.$typeName, ...[] ) as `${typeof PKG_V1}::act_cosmetic::Equip`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => Equip.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => Equip.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => Equip.fromBcs( data, ), bcs: Equip.bcs, fromJSONField: (field: any) => Equip.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => Equip.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => Equip.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => Equip.fetch( client, id, ), new: ( fields: EquipFields, ) => { return new Equip( [], fields ) }, kind: "StructClassReified", } }

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

/* ============================== ACT_COSMETIC =============================== */

export function isACT_COSMETIC(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::act_cosmetic::ACT_COSMETIC`; }

export interface ACT_COSMETICFields { dummyField: ToField<"bool"> }

export type ACT_COSMETICReified = Reified< ACT_COSMETIC, ACT_COSMETICFields >;

export class ACT_COSMETIC implements StructClass { static readonly $typeName = `${PKG_V1}::act_cosmetic::ACT_COSMETIC`; static readonly $numTypeParams = 0;

 readonly $typeName = ACT_COSMETIC.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::act_cosmetic::ACT_COSMETIC`;

 readonly $typeArgs: [];

 readonly dummyField: ToField<"bool">

 private constructor(typeArgs: [], fields: ACT_COSMETICFields, ) { this.$fullTypeName = composeSuiType( ACT_COSMETIC.$typeName, ...typeArgs ) as `${typeof PKG_V1}::act_cosmetic::ACT_COSMETIC`; this.$typeArgs = typeArgs;

 this.dummyField = fields.dummyField; }

 static reified( ): ACT_COSMETICReified { return { typeName: ACT_COSMETIC.$typeName, fullTypeName: composeSuiType( ACT_COSMETIC.$typeName, ...[] ) as `${typeof PKG_V1}::act_cosmetic::ACT_COSMETIC`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => ACT_COSMETIC.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => ACT_COSMETIC.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => ACT_COSMETIC.fromBcs( data, ), bcs: ACT_COSMETIC.bcs, fromJSONField: (field: any) => ACT_COSMETIC.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => ACT_COSMETIC.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => ACT_COSMETIC.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => ACT_COSMETIC.fetch( client, id, ), new: ( fields: ACT_COSMETICFields, ) => { return new ACT_COSMETIC( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return ACT_COSMETIC.reified() }

 static phantom( ): PhantomReified<ToTypeStr<ACT_COSMETIC>> { return phantom(ACT_COSMETIC.reified( )); } static get p() { return ACT_COSMETIC.phantom() }

 static get bcs() { return bcs.struct("ACT_COSMETIC", {

 dummy_field: bcs.bool()

}) };

 static fromFields( fields: Record<string, any> ): ACT_COSMETIC { return ACT_COSMETIC.reified( ).new( { dummyField: decodeFromFields("bool", fields.dummy_field) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): ACT_COSMETIC { if (!isACT_COSMETIC(item.type)) { throw new Error("not a ACT_COSMETIC type");

 }

 return ACT_COSMETIC.reified( ).new( { dummyField: decodeFromFieldsWithTypes("bool", item.fields.dummy_field) } ) }

 static fromBcs( data: Uint8Array ): ACT_COSMETIC { return ACT_COSMETIC.fromFields( ACT_COSMETIC.bcs.parse(data) ) }

 toJSONField() { return {

 dummyField: this.dummyField,

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): ACT_COSMETIC { return ACT_COSMETIC.reified( ).new( { dummyField: decodeFromJSONField("bool", field.dummyField) } ) }

 static fromJSON( json: Record<string, any> ): ACT_COSMETIC { if (json.$typeName !== ACT_COSMETIC.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return ACT_COSMETIC.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): ACT_COSMETIC { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isACT_COSMETIC(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a ACT_COSMETIC object`); } return ACT_COSMETIC.fromFieldsWithTypes( content ); }

 static async fetch( client: SuiClient, id: string ): Promise<ACT_COSMETIC> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching ACT_COSMETIC object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isACT_COSMETIC(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a ACT_COSMETIC object`); }
 return ACT_COSMETIC.fromBcs( fromB64(res.data.bcs.bcsBytes) ); }

 }

/* ============================== Cosmetic =============================== */

export function isCosmetic(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::act_cosmetic::Cosmetic`; }

export interface CosmeticFields { id: ToField<UID>; name: ToField<String>; imageUrl: ToField<String>; imageHash: ToField<String>; modelUrl: ToField<String>; type: ToField<String>; colourWay: ToField<String>; edition: ToField<String>; manufacturer: ToField<String>; rarity: ToField<String>; hash: ToField<String>; wearRating: ToField<"u64">; upgrades: ToField<Vector<Upgrade>> }

export type CosmeticReified = Reified< Cosmetic, CosmeticFields >;

export class Cosmetic implements StructClass { static readonly $typeName = `${PKG_V1}::act_cosmetic::Cosmetic`; static readonly $numTypeParams = 0;

 readonly $typeName = Cosmetic.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::act_cosmetic::Cosmetic`;

 readonly $typeArgs: [];

 readonly id: ToField<UID>; readonly name: ToField<String>; readonly imageUrl: ToField<String>; readonly imageHash: ToField<String>; readonly modelUrl: ToField<String>; readonly type: ToField<String>; readonly colourWay: ToField<String>; readonly edition: ToField<String>; readonly manufacturer: ToField<String>; readonly rarity: ToField<String>; readonly hash: ToField<String>; readonly wearRating: ToField<"u64">; readonly upgrades: ToField<Vector<Upgrade>>

 private constructor(typeArgs: [], fields: CosmeticFields, ) { this.$fullTypeName = composeSuiType( Cosmetic.$typeName, ...typeArgs ) as `${typeof PKG_V1}::act_cosmetic::Cosmetic`; this.$typeArgs = typeArgs;

 this.id = fields.id;; this.name = fields.name;; this.imageUrl = fields.imageUrl;; this.imageHash = fields.imageHash;; this.modelUrl = fields.modelUrl;; this.type = fields.type;; this.colourWay = fields.colourWay;; this.edition = fields.edition;; this.manufacturer = fields.manufacturer;; this.rarity = fields.rarity;; this.hash = fields.hash;; this.wearRating = fields.wearRating;; this.upgrades = fields.upgrades; }

 static reified( ): CosmeticReified { return { typeName: Cosmetic.$typeName, fullTypeName: composeSuiType( Cosmetic.$typeName, ...[] ) as `${typeof PKG_V1}::act_cosmetic::Cosmetic`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => Cosmetic.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => Cosmetic.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => Cosmetic.fromBcs( data, ), bcs: Cosmetic.bcs, fromJSONField: (field: any) => Cosmetic.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => Cosmetic.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => Cosmetic.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => Cosmetic.fetch( client, id, ), new: ( fields: CosmeticFields, ) => { return new Cosmetic( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return Cosmetic.reified() }

 static phantom( ): PhantomReified<ToTypeStr<Cosmetic>> { return phantom(Cosmetic.reified( )); } static get p() { return Cosmetic.phantom() }

 static get bcs() { return bcs.struct("Cosmetic", {

 id: UID.bcs, name: String.bcs, image_url: String.bcs, image_hash: String.bcs, model_url: String.bcs, type: String.bcs, colour_way: String.bcs, edition: String.bcs, manufacturer: String.bcs, rarity: String.bcs, hash: String.bcs, wear_rating: bcs.u64(), upgrades: bcs.vector(Upgrade.bcs)

}) };

 static fromFields( fields: Record<string, any> ): Cosmetic { return Cosmetic.reified( ).new( { id: decodeFromFields(UID.reified(), fields.id), name: decodeFromFields(String.reified(), fields.name), imageUrl: decodeFromFields(String.reified(), fields.image_url), imageHash: decodeFromFields(String.reified(), fields.image_hash), modelUrl: decodeFromFields(String.reified(), fields.model_url), type: decodeFromFields(String.reified(), fields.type), colourWay: decodeFromFields(String.reified(), fields.colour_way), edition: decodeFromFields(String.reified(), fields.edition), manufacturer: decodeFromFields(String.reified(), fields.manufacturer), rarity: decodeFromFields(String.reified(), fields.rarity), hash: decodeFromFields(String.reified(), fields.hash), wearRating: decodeFromFields("u64", fields.wear_rating), upgrades: decodeFromFields(reified.vector(Upgrade.reified()), fields.upgrades) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): Cosmetic { if (!isCosmetic(item.type)) { throw new Error("not a Cosmetic type");

 }

 return Cosmetic.reified( ).new( { id: decodeFromFieldsWithTypes(UID.reified(), item.fields.id), name: decodeFromFieldsWithTypes(String.reified(), item.fields.name), imageUrl: decodeFromFieldsWithTypes(String.reified(), item.fields.image_url), imageHash: decodeFromFieldsWithTypes(String.reified(), item.fields.image_hash), modelUrl: decodeFromFieldsWithTypes(String.reified(), item.fields.model_url), type: decodeFromFieldsWithTypes(String.reified(), item.fields.type), colourWay: decodeFromFieldsWithTypes(String.reified(), item.fields.colour_way), edition: decodeFromFieldsWithTypes(String.reified(), item.fields.edition), manufacturer: decodeFromFieldsWithTypes(String.reified(), item.fields.manufacturer), rarity: decodeFromFieldsWithTypes(String.reified(), item.fields.rarity), hash: decodeFromFieldsWithTypes(String.reified(), item.fields.hash), wearRating: decodeFromFieldsWithTypes("u64", item.fields.wear_rating), upgrades: decodeFromFieldsWithTypes(reified.vector(Upgrade.reified()), item.fields.upgrades) } ) }

 static fromBcs( data: Uint8Array ): Cosmetic { return Cosmetic.fromFields( Cosmetic.bcs.parse(data) ) }

 toJSONField() { return {

 id: this.id,name: this.name,imageUrl: this.imageUrl,imageHash: this.imageHash,modelUrl: this.modelUrl,type: this.type,colourWay: this.colourWay,edition: this.edition,manufacturer: this.manufacturer,rarity: this.rarity,hash: this.hash,wearRating: this.wearRating.toString(),upgrades: fieldToJSON<Vector<Upgrade>>(`vector<${Upgrade.$typeName}>`, this.upgrades),

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): Cosmetic { return Cosmetic.reified( ).new( { id: decodeFromJSONField(UID.reified(), field.id), name: decodeFromJSONField(String.reified(), field.name), imageUrl: decodeFromJSONField(String.reified(), field.imageUrl), imageHash: decodeFromJSONField(String.reified(), field.imageHash), modelUrl: decodeFromJSONField(String.reified(), field.modelUrl), type: decodeFromJSONField(String.reified(), field.type), colourWay: decodeFromJSONField(String.reified(), field.colourWay), edition: decodeFromJSONField(String.reified(), field.edition), manufacturer: decodeFromJSONField(String.reified(), field.manufacturer), rarity: decodeFromJSONField(String.reified(), field.rarity), hash: decodeFromJSONField(String.reified(), field.hash), wearRating: decodeFromJSONField("u64", field.wearRating), upgrades: decodeFromJSONField(reified.vector(Upgrade.reified()), field.upgrades) } ) }

 static fromJSON( json: Record<string, any> ): Cosmetic { if (json.$typeName !== Cosmetic.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return Cosmetic.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): Cosmetic { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isCosmetic(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a Cosmetic object`); } return Cosmetic.fromFieldsWithTypes( content ); }

 static async fetch( client: SuiClient, id: string ): Promise<Cosmetic> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching Cosmetic object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isCosmetic(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a Cosmetic object`); }
 return Cosmetic.fromBcs( fromB64(res.data.bcs.bcsBytes) ); }

 }
