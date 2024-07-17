import * as reified from "../../_framework/reified";
import {String} from "../../_dependencies/source/0x1/string/structs";
import {UID} from "../../_dependencies/source/0x2/object/structs";
import {PhantomReified, Reified, StructClass, ToField, ToTypeStr, Vector, decodeFromFields, decodeFromFieldsWithTypes, decodeFromJSONField, fieldToJSON, phantom} from "../../_framework/reified";
import {FieldsWithTypes, composeSuiType, compressSuiType} from "../../_framework/util";
import {Item} from "../act-genesis-shop/structs";
import {PKG_V1} from "../index";
import {bcs, fromB64} from "@mysten/bcs";
import {SuiClient, SuiParsedData} from "@mysten/sui/client";

/* ============================== AvatarTicket =============================== */

export function isAvatarTicket(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::act_genesis_drop::AvatarTicket`; }

export interface AvatarTicketFields { id: ToField<UID>; drop: ToField<Vector<Item>>; username: ToField<String>; imageUrl: ToField<String>; imageHash: ToField<String>; modelUrl: ToField<String> }

export type AvatarTicketReified = Reified< AvatarTicket, AvatarTicketFields >;

export class AvatarTicket implements StructClass { static readonly $typeName = `${PKG_V1}::act_genesis_drop::AvatarTicket`; static readonly $numTypeParams = 0;

 readonly $typeName = AvatarTicket.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::act_genesis_drop::AvatarTicket`;

 readonly $typeArgs: [];

 readonly id: ToField<UID>; readonly drop: ToField<Vector<Item>>; readonly username: ToField<String>; readonly imageUrl: ToField<String>; readonly imageHash: ToField<String>; readonly modelUrl: ToField<String>

 private constructor(typeArgs: [], fields: AvatarTicketFields, ) { this.$fullTypeName = composeSuiType( AvatarTicket.$typeName, ...typeArgs ) as `${typeof PKG_V1}::act_genesis_drop::AvatarTicket`; this.$typeArgs = typeArgs;

 this.id = fields.id;; this.drop = fields.drop;; this.username = fields.username;; this.imageUrl = fields.imageUrl;; this.imageHash = fields.imageHash;; this.modelUrl = fields.modelUrl; }

 static reified( ): AvatarTicketReified { return { typeName: AvatarTicket.$typeName, fullTypeName: composeSuiType( AvatarTicket.$typeName, ...[] ) as `${typeof PKG_V1}::act_genesis_drop::AvatarTicket`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => AvatarTicket.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => AvatarTicket.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => AvatarTicket.fromBcs( data, ), bcs: AvatarTicket.bcs, fromJSONField: (field: any) => AvatarTicket.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => AvatarTicket.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => AvatarTicket.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => AvatarTicket.fetch( client, id, ), new: ( fields: AvatarTicketFields, ) => { return new AvatarTicket( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return AvatarTicket.reified() }

 static phantom( ): PhantomReified<ToTypeStr<AvatarTicket>> { return phantom(AvatarTicket.reified( )); } static get p() { return AvatarTicket.phantom() }

 static get bcs() { return bcs.struct("AvatarTicket", {

 id: UID.bcs, drop: bcs.vector(Item.bcs), username: String.bcs, image_url: String.bcs, image_hash: String.bcs, model_url: String.bcs

}) };

 static fromFields( fields: Record<string, any> ): AvatarTicket { return AvatarTicket.reified( ).new( { id: decodeFromFields(UID.reified(), fields.id), drop: decodeFromFields(reified.vector(Item.reified()), fields.drop), username: decodeFromFields(String.reified(), fields.username), imageUrl: decodeFromFields(String.reified(), fields.image_url), imageHash: decodeFromFields(String.reified(), fields.image_hash), modelUrl: decodeFromFields(String.reified(), fields.model_url) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): AvatarTicket { if (!isAvatarTicket(item.type)) { throw new Error("not a AvatarTicket type");

 }

 return AvatarTicket.reified( ).new( { id: decodeFromFieldsWithTypes(UID.reified(), item.fields.id), drop: decodeFromFieldsWithTypes(reified.vector(Item.reified()), item.fields.drop), username: decodeFromFieldsWithTypes(String.reified(), item.fields.username), imageUrl: decodeFromFieldsWithTypes(String.reified(), item.fields.image_url), imageHash: decodeFromFieldsWithTypes(String.reified(), item.fields.image_hash), modelUrl: decodeFromFieldsWithTypes(String.reified(), item.fields.model_url) } ) }

 static fromBcs( data: Uint8Array ): AvatarTicket { return AvatarTicket.fromFields( AvatarTicket.bcs.parse(data) ) }

 toJSONField() { return {

 id: this.id,drop: fieldToJSON<Vector<Item>>(`vector<${Item.$typeName}>`, this.drop),username: this.username,imageUrl: this.imageUrl,imageHash: this.imageHash,modelUrl: this.modelUrl,

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): AvatarTicket { return AvatarTicket.reified( ).new( { id: decodeFromJSONField(UID.reified(), field.id), drop: decodeFromJSONField(reified.vector(Item.reified()), field.drop), username: decodeFromJSONField(String.reified(), field.username), imageUrl: decodeFromJSONField(String.reified(), field.imageUrl), imageHash: decodeFromJSONField(String.reified(), field.imageHash), modelUrl: decodeFromJSONField(String.reified(), field.modelUrl) } ) }

 static fromJSON( json: Record<string, any> ): AvatarTicket { if (json.$typeName !== AvatarTicket.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return AvatarTicket.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): AvatarTicket { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isAvatarTicket(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a AvatarTicket object`); } return AvatarTicket.fromFieldsWithTypes( content ); }

 static async fetch( client: SuiClient, id: string ): Promise<AvatarTicket> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching AvatarTicket object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isAvatarTicket(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a AvatarTicket object`); }
 return AvatarTicket.fromBcs( fromB64(res.data.bcs.bcsBytes) ); }

 }

/* ============================== GenesisPass =============================== */

export function isGenesisPass(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::act_genesis_drop::GenesisPass`; }

export interface GenesisPassFields { id: ToField<UID>; phase: ToField<"u64"> }

export type GenesisPassReified = Reified< GenesisPass, GenesisPassFields >;

export class GenesisPass implements StructClass { static readonly $typeName = `${PKG_V1}::act_genesis_drop::GenesisPass`; static readonly $numTypeParams = 0;

 readonly $typeName = GenesisPass.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::act_genesis_drop::GenesisPass`;

 readonly $typeArgs: [];

 readonly id: ToField<UID>; readonly phase: ToField<"u64">

 private constructor(typeArgs: [], fields: GenesisPassFields, ) { this.$fullTypeName = composeSuiType( GenesisPass.$typeName, ...typeArgs ) as `${typeof PKG_V1}::act_genesis_drop::GenesisPass`; this.$typeArgs = typeArgs;

 this.id = fields.id;; this.phase = fields.phase; }

 static reified( ): GenesisPassReified { return { typeName: GenesisPass.$typeName, fullTypeName: composeSuiType( GenesisPass.$typeName, ...[] ) as `${typeof PKG_V1}::act_genesis_drop::GenesisPass`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => GenesisPass.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => GenesisPass.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => GenesisPass.fromBcs( data, ), bcs: GenesisPass.bcs, fromJSONField: (field: any) => GenesisPass.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => GenesisPass.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => GenesisPass.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => GenesisPass.fetch( client, id, ), new: ( fields: GenesisPassFields, ) => { return new GenesisPass( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return GenesisPass.reified() }

 static phantom( ): PhantomReified<ToTypeStr<GenesisPass>> { return phantom(GenesisPass.reified( )); } static get p() { return GenesisPass.phantom() }

 static get bcs() { return bcs.struct("GenesisPass", {

 id: UID.bcs, phase: bcs.u64()

}) };

 static fromFields( fields: Record<string, any> ): GenesisPass { return GenesisPass.reified( ).new( { id: decodeFromFields(UID.reified(), fields.id), phase: decodeFromFields("u64", fields.phase) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): GenesisPass { if (!isGenesisPass(item.type)) { throw new Error("not a GenesisPass type");

 }

 return GenesisPass.reified( ).new( { id: decodeFromFieldsWithTypes(UID.reified(), item.fields.id), phase: decodeFromFieldsWithTypes("u64", item.fields.phase) } ) }

 static fromBcs( data: Uint8Array ): GenesisPass { return GenesisPass.fromFields( GenesisPass.bcs.parse(data) ) }

 toJSONField() { return {

 id: this.id,phase: this.phase.toString(),

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): GenesisPass { return GenesisPass.reified( ).new( { id: decodeFromJSONField(UID.reified(), field.id), phase: decodeFromJSONField("u64", field.phase) } ) }

 static fromJSON( json: Record<string, any> ): GenesisPass { if (json.$typeName !== GenesisPass.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return GenesisPass.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): GenesisPass { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isGenesisPass(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a GenesisPass object`); } return GenesisPass.fromFieldsWithTypes( content ); }

 static async fetch( client: SuiClient, id: string ): Promise<GenesisPass> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching GenesisPass object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isGenesisPass(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a GenesisPass object`); }
 return GenesisPass.fromBcs( fromB64(res.data.bcs.bcsBytes) ); }

 }

/* ============================== Sale =============================== */

export function isSale(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::act_genesis_drop::Sale`; }

export interface SaleFields { id: ToField<UID>; active: ToField<"bool">; startTimes: ToField<Vector<"u64">>; prices: ToField<Vector<"u64">>; maxMints: ToField<Vector<"u64">>; dropsLeft: ToField<"u64"> }

export type SaleReified = Reified< Sale, SaleFields >;

export class Sale implements StructClass { static readonly $typeName = `${PKG_V1}::act_genesis_drop::Sale`; static readonly $numTypeParams = 0;

 readonly $typeName = Sale.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::act_genesis_drop::Sale`;

 readonly $typeArgs: [];

 readonly id: ToField<UID>; readonly active: ToField<"bool">; readonly startTimes: ToField<Vector<"u64">>; readonly prices: ToField<Vector<"u64">>; readonly maxMints: ToField<Vector<"u64">>; readonly dropsLeft: ToField<"u64">

 private constructor(typeArgs: [], fields: SaleFields, ) { this.$fullTypeName = composeSuiType( Sale.$typeName, ...typeArgs ) as `${typeof PKG_V1}::act_genesis_drop::Sale`; this.$typeArgs = typeArgs;

 this.id = fields.id;; this.active = fields.active;; this.startTimes = fields.startTimes;; this.prices = fields.prices;; this.maxMints = fields.maxMints;; this.dropsLeft = fields.dropsLeft; }

 static reified( ): SaleReified { return { typeName: Sale.$typeName, fullTypeName: composeSuiType( Sale.$typeName, ...[] ) as `${typeof PKG_V1}::act_genesis_drop::Sale`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => Sale.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => Sale.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => Sale.fromBcs( data, ), bcs: Sale.bcs, fromJSONField: (field: any) => Sale.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => Sale.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => Sale.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => Sale.fetch( client, id, ), new: ( fields: SaleFields, ) => { return new Sale( [], fields ) }, kind: "StructClassReified", } }

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

 static async fetch( client: SuiClient, id: string ): Promise<Sale> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching Sale object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isSale(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a Sale object`); }
 return Sale.fromBcs( fromB64(res.data.bcs.bcsBytes) ); }

 }
