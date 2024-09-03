import * as reified from "../../_framework/reified";
import {String} from "../../_dependencies/source/0x1/string/structs";
import {UID} from "../../_dependencies/source/0x2/object/structs";
import {PhantomReified, Reified, StructClass, ToField, ToTypeStr, decodeFromFields, decodeFromFieldsWithTypes, decodeFromJSONField, fieldToJSON, phantom} from "../../_framework/reified";
import {FieldsWithTypes, composeSuiType, compressSuiType} from "../../_framework/util";
import {Vector} from "../../_framework/vector";
import {PKG_V1} from "../index";
import {bcs} from "@mysten/sui/bcs";
import {SuiClient, SuiObjectData, SuiParsedData} from "@mysten/sui/client";
import {fromB64} from "@mysten/sui/utils";

/* ============================== GENESIS_DROP =============================== */

export function isGENESIS_DROP(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::genesis_drop::GENESIS_DROP`; }

export interface GENESIS_DROPFields { dummyField: ToField<"bool"> }

export type GENESIS_DROPReified = Reified< GENESIS_DROP, GENESIS_DROPFields >;

export class GENESIS_DROP implements StructClass { __StructClass = true as const;

 static readonly $typeName = `${PKG_V1}::genesis_drop::GENESIS_DROP`; static readonly $numTypeParams = 0; static readonly $isPhantom = [] as const;

 readonly $typeName = GENESIS_DROP.$typeName; readonly $fullTypeName: `${typeof PKG_V1}::genesis_drop::GENESIS_DROP`; readonly $typeArgs: []; readonly $isPhantom = GENESIS_DROP.$isPhantom;

 readonly dummyField: ToField<"bool">

 private constructor(typeArgs: [], fields: GENESIS_DROPFields, ) { this.$fullTypeName = composeSuiType( GENESIS_DROP.$typeName, ...typeArgs ) as `${typeof PKG_V1}::genesis_drop::GENESIS_DROP`; this.$typeArgs = typeArgs;

 this.dummyField = fields.dummyField; }

 static reified( ): GENESIS_DROPReified { return { typeName: GENESIS_DROP.$typeName, fullTypeName: composeSuiType( GENESIS_DROP.$typeName, ...[] ) as `${typeof PKG_V1}::genesis_drop::GENESIS_DROP`, typeArgs: [ ] as [], isPhantom: GENESIS_DROP.$isPhantom, reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => GENESIS_DROP.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => GENESIS_DROP.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => GENESIS_DROP.fromBcs( data, ), bcs: GENESIS_DROP.bcs, fromJSONField: (field: any) => GENESIS_DROP.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => GENESIS_DROP.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => GENESIS_DROP.fromSuiParsedData( content, ), fromSuiObjectData: (content: SuiObjectData) => GENESIS_DROP.fromSuiObjectData( content, ), fetch: async (client: SuiClient, id: string) => GENESIS_DROP.fetch( client, id, ), new: ( fields: GENESIS_DROPFields, ) => { return new GENESIS_DROP( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return GENESIS_DROP.reified() }

 static phantom( ): PhantomReified<ToTypeStr<GENESIS_DROP>> { return phantom(GENESIS_DROP.reified( )); } static get p() { return GENESIS_DROP.phantom() }

 static get bcs() { return bcs.struct("GENESIS_DROP", {

 dummy_field: bcs.bool()

}) };

 static fromFields( fields: Record<string, any> ): GENESIS_DROP { return GENESIS_DROP.reified( ).new( { dummyField: decodeFromFields("bool", fields.dummy_field) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): GENESIS_DROP { if (!isGENESIS_DROP(item.type)) { throw new Error("not a GENESIS_DROP type");

 }

 return GENESIS_DROP.reified( ).new( { dummyField: decodeFromFieldsWithTypes("bool", item.fields.dummy_field) } ) }

 static fromBcs( data: Uint8Array ): GENESIS_DROP { return GENESIS_DROP.fromFields( GENESIS_DROP.bcs.parse(data) ) }

 toJSONField() { return {

 dummyField: this.dummyField,

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): GENESIS_DROP { return GENESIS_DROP.reified( ).new( { dummyField: decodeFromJSONField("bool", field.dummyField) } ) }

 static fromJSON( json: Record<string, any> ): GENESIS_DROP { if (json.$typeName !== GENESIS_DROP.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return GENESIS_DROP.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): GENESIS_DROP { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isGENESIS_DROP(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a GENESIS_DROP object`); } return GENESIS_DROP.fromFieldsWithTypes( content ); }

 static fromSuiObjectData( data: SuiObjectData ): GENESIS_DROP { if (data.bcs) { if (data.bcs.dataType !== "moveObject" || !isGENESIS_DROP(data.bcs.type)) { throw new Error(`object at is not a GENESIS_DROP object`); }

 return GENESIS_DROP.fromBcs( fromB64(data.bcs.bcsBytes) ); } if (data.content) { return GENESIS_DROP.fromSuiParsedData( data.content ) } throw new Error( "Both `bcs` and `content` fields are missing from the data. Include `showBcs` or `showContent` in the request." ); }

 static async fetch( client: SuiClient, id: string ): Promise<GENESIS_DROP> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching GENESIS_DROP object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isGENESIS_DROP(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a GENESIS_DROP object`); }

 return GENESIS_DROP.fromSuiObjectData( res.data ); }

 }

/* ============================== GenesisPass =============================== */

export function isGenesisPass(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::genesis_drop::GenesisPass`; }

export interface GenesisPassFields { id: ToField<UID>; phase: ToField<"u64">; name: ToField<String>; imageUrl: ToField<String>; description: ToField<String> }

export type GenesisPassReified = Reified< GenesisPass, GenesisPassFields >;

export class GenesisPass implements StructClass { __StructClass = true as const;

 static readonly $typeName = `${PKG_V1}::genesis_drop::GenesisPass`; static readonly $numTypeParams = 0; static readonly $isPhantom = [] as const;

 readonly $typeName = GenesisPass.$typeName; readonly $fullTypeName: `${typeof PKG_V1}::genesis_drop::GenesisPass`; readonly $typeArgs: []; readonly $isPhantom = GenesisPass.$isPhantom;

 readonly id: ToField<UID>; readonly phase: ToField<"u64">; readonly name: ToField<String>; readonly imageUrl: ToField<String>; readonly description: ToField<String>

 private constructor(typeArgs: [], fields: GenesisPassFields, ) { this.$fullTypeName = composeSuiType( GenesisPass.$typeName, ...typeArgs ) as `${typeof PKG_V1}::genesis_drop::GenesisPass`; this.$typeArgs = typeArgs;

 this.id = fields.id;; this.phase = fields.phase;; this.name = fields.name;; this.imageUrl = fields.imageUrl;; this.description = fields.description; }

 static reified( ): GenesisPassReified { return { typeName: GenesisPass.$typeName, fullTypeName: composeSuiType( GenesisPass.$typeName, ...[] ) as `${typeof PKG_V1}::genesis_drop::GenesisPass`, typeArgs: [ ] as [], isPhantom: GenesisPass.$isPhantom, reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => GenesisPass.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => GenesisPass.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => GenesisPass.fromBcs( data, ), bcs: GenesisPass.bcs, fromJSONField: (field: any) => GenesisPass.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => GenesisPass.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => GenesisPass.fromSuiParsedData( content, ), fromSuiObjectData: (content: SuiObjectData) => GenesisPass.fromSuiObjectData( content, ), fetch: async (client: SuiClient, id: string) => GenesisPass.fetch( client, id, ), new: ( fields: GenesisPassFields, ) => { return new GenesisPass( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return GenesisPass.reified() }

 static phantom( ): PhantomReified<ToTypeStr<GenesisPass>> { return phantom(GenesisPass.reified( )); } static get p() { return GenesisPass.phantom() }

 static get bcs() { return bcs.struct("GenesisPass", {

 id: UID.bcs, phase: bcs.u64(), name: String.bcs, image_url: String.bcs, description: String.bcs

}) };

 static fromFields( fields: Record<string, any> ): GenesisPass { return GenesisPass.reified( ).new( { id: decodeFromFields(UID.reified(), fields.id), phase: decodeFromFields("u64", fields.phase), name: decodeFromFields(String.reified(), fields.name), imageUrl: decodeFromFields(String.reified(), fields.image_url), description: decodeFromFields(String.reified(), fields.description) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): GenesisPass { if (!isGenesisPass(item.type)) { throw new Error("not a GenesisPass type");

 }

 return GenesisPass.reified( ).new( { id: decodeFromFieldsWithTypes(UID.reified(), item.fields.id), phase: decodeFromFieldsWithTypes("u64", item.fields.phase), name: decodeFromFieldsWithTypes(String.reified(), item.fields.name), imageUrl: decodeFromFieldsWithTypes(String.reified(), item.fields.image_url), description: decodeFromFieldsWithTypes(String.reified(), item.fields.description) } ) }

 static fromBcs( data: Uint8Array ): GenesisPass { return GenesisPass.fromFields( GenesisPass.bcs.parse(data) ) }

 toJSONField() { return {

 id: this.id,phase: this.phase.toString(),name: this.name,imageUrl: this.imageUrl,description: this.description,

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): GenesisPass { return GenesisPass.reified( ).new( { id: decodeFromJSONField(UID.reified(), field.id), phase: decodeFromJSONField("u64", field.phase), name: decodeFromJSONField(String.reified(), field.name), imageUrl: decodeFromJSONField(String.reified(), field.imageUrl), description: decodeFromJSONField(String.reified(), field.description) } ) }

 static fromJSON( json: Record<string, any> ): GenesisPass { if (json.$typeName !== GenesisPass.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return GenesisPass.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): GenesisPass { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isGenesisPass(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a GenesisPass object`); } return GenesisPass.fromFieldsWithTypes( content ); }

 static fromSuiObjectData( data: SuiObjectData ): GenesisPass { if (data.bcs) { if (data.bcs.dataType !== "moveObject" || !isGenesisPass(data.bcs.type)) { throw new Error(`object at is not a GenesisPass object`); }

 return GenesisPass.fromBcs( fromB64(data.bcs.bcsBytes) ); } if (data.content) { return GenesisPass.fromSuiParsedData( data.content ) } throw new Error( "Both `bcs` and `content` fields are missing from the data. Include `showBcs` or `showContent` in the request." ); }

 static async fetch( client: SuiClient, id: string ): Promise<GenesisPass> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching GenesisPass object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isGenesisPass(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a GenesisPass object`); }

 return GenesisPass.fromSuiObjectData( res.data ); }

 }

/* ============================== Sale =============================== */

export function isSale(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::genesis_drop::Sale`; }

export interface SaleFields { id: ToField<UID>; active: ToField<"bool">; startTimes: ToField<Vector<"u64">>; prices: ToField<Vector<"u64">>; maxMints: ToField<Vector<"u64">>; dropsLeft: ToField<"u64"> }

export type SaleReified = Reified< Sale, SaleFields >;

export class Sale implements StructClass { __StructClass = true as const;

 static readonly $typeName = `${PKG_V1}::genesis_drop::Sale`; static readonly $numTypeParams = 0; static readonly $isPhantom = [] as const;

 readonly $typeName = Sale.$typeName; readonly $fullTypeName: `${typeof PKG_V1}::genesis_drop::Sale`; readonly $typeArgs: []; readonly $isPhantom = Sale.$isPhantom;

 readonly id: ToField<UID>; readonly active: ToField<"bool">; readonly startTimes: ToField<Vector<"u64">>; readonly prices: ToField<Vector<"u64">>; readonly maxMints: ToField<Vector<"u64">>; readonly dropsLeft: ToField<"u64">

 private constructor(typeArgs: [], fields: SaleFields, ) { this.$fullTypeName = composeSuiType( Sale.$typeName, ...typeArgs ) as `${typeof PKG_V1}::genesis_drop::Sale`; this.$typeArgs = typeArgs;

 this.id = fields.id;; this.active = fields.active;; this.startTimes = fields.startTimes;; this.prices = fields.prices;; this.maxMints = fields.maxMints;; this.dropsLeft = fields.dropsLeft; }

 static reified( ): SaleReified { return { typeName: Sale.$typeName, fullTypeName: composeSuiType( Sale.$typeName, ...[] ) as `${typeof PKG_V1}::genesis_drop::Sale`, typeArgs: [ ] as [], isPhantom: Sale.$isPhantom, reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => Sale.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => Sale.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => Sale.fromBcs( data, ), bcs: Sale.bcs, fromJSONField: (field: any) => Sale.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => Sale.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => Sale.fromSuiParsedData( content, ), fromSuiObjectData: (content: SuiObjectData) => Sale.fromSuiObjectData( content, ), fetch: async (client: SuiClient, id: string) => Sale.fetch( client, id, ), new: ( fields: SaleFields, ) => { return new Sale( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return Sale.reified() }

 static phantom( ): PhantomReified<ToTypeStr<Sale>> { return phantom(Sale.reified( )); } static get p() { return Sale.phantom() }

 static get bcs() { return bcs.struct("Sale", {

 id: UID.bcs, active: bcs.bool(), start_times: bcs.vector(bcs.u64()), prices: bcs.vector(bcs.u64()), max_mints: bcs.vector(bcs.u64()), drops_left: bcs.u64()

}) };

 static fromFields( fields: Record<string, any> ): Sale { return Sale.reified( ).new( { id: decodeFromFields(UID.reified(), fields.id), active: decodeFromFields("bool", fields.active), startTimes: decodeFromFields(reified.vector("u64"), fields.start_times), prices: decodeFromFields(reified.vector("u64"), fields.prices), maxMints: decodeFromFields(reified.vector("u64"), fields.max_mints), dropsLeft: decodeFromFields("u64", fields.drops_left) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): Sale { if (!isSale(item.type)) { throw new Error("not a Sale type");

 }

 return Sale.reified( ).new( { id: decodeFromFieldsWithTypes(UID.reified(), item.fields.id), active: decodeFromFieldsWithTypes("bool", item.fields.active), startTimes: decodeFromFieldsWithTypes(reified.vector("u64"), item.fields.start_times), prices: decodeFromFieldsWithTypes(reified.vector("u64"), item.fields.prices), maxMints: decodeFromFieldsWithTypes(reified.vector("u64"), item.fields.max_mints), dropsLeft: decodeFromFieldsWithTypes("u64", item.fields.drops_left) } ) }

 static fromBcs( data: Uint8Array ): Sale { return Sale.fromFields( Sale.bcs.parse(data) ) }

 toJSONField() { return {

 id: this.id,active: this.active,startTimes: fieldToJSON<Vector<"u64">>(`vector<u64>`, this.startTimes),prices: fieldToJSON<Vector<"u64">>(`vector<u64>`, this.prices),maxMints: fieldToJSON<Vector<"u64">>(`vector<u64>`, this.maxMints),dropsLeft: this.dropsLeft.toString(),

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): Sale { return Sale.reified( ).new( { id: decodeFromJSONField(UID.reified(), field.id), active: decodeFromJSONField("bool", field.active), startTimes: decodeFromJSONField(reified.vector("u64"), field.startTimes), prices: decodeFromJSONField(reified.vector("u64"), field.prices), maxMints: decodeFromJSONField(reified.vector("u64"), field.maxMints), dropsLeft: decodeFromJSONField("u64", field.dropsLeft) } ) }

 static fromJSON( json: Record<string, any> ): Sale { if (json.$typeName !== Sale.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return Sale.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): Sale { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isSale(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a Sale object`); } return Sale.fromFieldsWithTypes( content ); }

 static fromSuiObjectData( data: SuiObjectData ): Sale { if (data.bcs) { if (data.bcs.dataType !== "moveObject" || !isSale(data.bcs.type)) { throw new Error(`object at is not a Sale object`); }

 return Sale.fromBcs( fromB64(data.bcs.bcsBytes) ); } if (data.content) { return Sale.fromSuiParsedData( data.content ) } throw new Error( "Both `bcs` and `content` fields are missing from the data. Include `showBcs` or `showContent` in the request." ); }

 static async fetch( client: SuiClient, id: string ): Promise<Sale> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching Sale object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isSale(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a Sale object`); }

 return Sale.fromSuiObjectData( res.data ); }

 }
