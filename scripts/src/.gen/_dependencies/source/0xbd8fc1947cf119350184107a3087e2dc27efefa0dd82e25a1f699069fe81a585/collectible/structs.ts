import * as reified from "../../../../_framework/reified";
import {PhantomReified, PhantomToTypeStr, PhantomTypeArgument, Reified, StructClass, ToField, ToPhantomTypeArgument, ToTypeArgument, ToTypeStr, TypeArgument, assertFieldsWithTypesArgsMatch, assertReifiedTypeArgsMatch, decodeFromFields, decodeFromFieldsWithTypes, decodeFromJSONField, extractType, fieldToJSON, phantom, toBcs, ToTypeStr as ToPhantom} from "../../../../_framework/reified";
import {FieldsWithTypes, composeSuiType, compressSuiType} from "../../../../_framework/util";
import {Option} from "../../0x1/option/structs";
import {String} from "../../0x1/string/structs";
import {Referent} from "../../0x2/borrow/structs";
import {Display} from "../../0x2/display/structs";
import {UID} from "../../0x2/object/structs";
import {Publisher} from "../../0x2/package/structs";
import {TransferPolicyCap} from "../../0x2/transfer-policy/structs";
import {PKG_V1} from "../index";
import {BcsType, bcs, fromB64} from "@mysten/bcs";
import {SuiClient, SuiParsedData} from "@mysten/sui/client";

/* ============================== Registry =============================== */

export function isRegistry(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::collectible::Registry`; }

export interface RegistryFields { id: ToField<UID>; publisher: ToField<Publisher> }

export type RegistryReified = Reified< Registry, RegistryFields >;

export class Registry implements StructClass { static readonly $typeName = `${PKG_V1}::collectible::Registry`; static readonly $numTypeParams = 0;

 readonly $typeName = Registry.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::collectible::Registry`;

 readonly $typeArgs: [];

 readonly id: ToField<UID>; readonly publisher: ToField<Publisher>

 private constructor(typeArgs: [], fields: RegistryFields, ) { this.$fullTypeName = composeSuiType( Registry.$typeName, ...typeArgs ) as `${typeof PKG_V1}::collectible::Registry`; this.$typeArgs = typeArgs;

 this.id = fields.id;; this.publisher = fields.publisher; }

 static reified( ): RegistryReified { return { typeName: Registry.$typeName, fullTypeName: composeSuiType( Registry.$typeName, ...[] ) as `${typeof PKG_V1}::collectible::Registry`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => Registry.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => Registry.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => Registry.fromBcs( data, ), bcs: Registry.bcs, fromJSONField: (field: any) => Registry.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => Registry.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => Registry.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => Registry.fetch( client, id, ), new: ( fields: RegistryFields, ) => { return new Registry( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return Registry.reified() }

 static phantom( ): PhantomReified<ToTypeStr<Registry>> { return phantom(Registry.reified( )); } static get p() { return Registry.phantom() }

 static get bcs() { return bcs.struct("Registry", {

 id: UID.bcs, publisher: Publisher.bcs

}) };

 static fromFields( fields: Record<string, any> ): Registry { return Registry.reified( ).new( { id: decodeFromFields(UID.reified(), fields.id), publisher: decodeFromFields(Publisher.reified(), fields.publisher) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): Registry { if (!isRegistry(item.type)) { throw new Error("not a Registry type");

 }

 return Registry.reified( ).new( { id: decodeFromFieldsWithTypes(UID.reified(), item.fields.id), publisher: decodeFromFieldsWithTypes(Publisher.reified(), item.fields.publisher) } ) }

 static fromBcs( data: Uint8Array ): Registry { return Registry.fromFields( Registry.bcs.parse(data) ) }

 toJSONField() { return {

 id: this.id,publisher: this.publisher.toJSONField(),

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): Registry { return Registry.reified( ).new( { id: decodeFromJSONField(UID.reified(), field.id), publisher: decodeFromJSONField(Publisher.reified(), field.publisher) } ) }

 static fromJSON( json: Record<string, any> ): Registry { if (json.$typeName !== Registry.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return Registry.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): Registry { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isRegistry(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a Registry object`); } return Registry.fromFieldsWithTypes( content ); }

 static async fetch( client: SuiClient, id: string ): Promise<Registry> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching Registry object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isRegistry(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a Registry object`); }
 return Registry.fromBcs( fromB64(res.data.bcs.bcsBytes) ); }

 }

/* ============================== COLLECTIBLE =============================== */

export function isCOLLECTIBLE(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::collectible::COLLECTIBLE`; }

export interface COLLECTIBLEFields { dummyField: ToField<"bool"> }

export type COLLECTIBLEReified = Reified< COLLECTIBLE, COLLECTIBLEFields >;

export class COLLECTIBLE implements StructClass { static readonly $typeName = `${PKG_V1}::collectible::COLLECTIBLE`; static readonly $numTypeParams = 0;

 readonly $typeName = COLLECTIBLE.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::collectible::COLLECTIBLE`;

 readonly $typeArgs: [];

 readonly dummyField: ToField<"bool">

 private constructor(typeArgs: [], fields: COLLECTIBLEFields, ) { this.$fullTypeName = composeSuiType( COLLECTIBLE.$typeName, ...typeArgs ) as `${typeof PKG_V1}::collectible::COLLECTIBLE`; this.$typeArgs = typeArgs;

 this.dummyField = fields.dummyField; }

 static reified( ): COLLECTIBLEReified { return { typeName: COLLECTIBLE.$typeName, fullTypeName: composeSuiType( COLLECTIBLE.$typeName, ...[] ) as `${typeof PKG_V1}::collectible::COLLECTIBLE`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => COLLECTIBLE.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => COLLECTIBLE.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => COLLECTIBLE.fromBcs( data, ), bcs: COLLECTIBLE.bcs, fromJSONField: (field: any) => COLLECTIBLE.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => COLLECTIBLE.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => COLLECTIBLE.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => COLLECTIBLE.fetch( client, id, ), new: ( fields: COLLECTIBLEFields, ) => { return new COLLECTIBLE( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return COLLECTIBLE.reified() }

 static phantom( ): PhantomReified<ToTypeStr<COLLECTIBLE>> { return phantom(COLLECTIBLE.reified( )); } static get p() { return COLLECTIBLE.phantom() }

 static get bcs() { return bcs.struct("COLLECTIBLE", {

 dummy_field: bcs.bool()

}) };

 static fromFields( fields: Record<string, any> ): COLLECTIBLE { return COLLECTIBLE.reified( ).new( { dummyField: decodeFromFields("bool", fields.dummy_field) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): COLLECTIBLE { if (!isCOLLECTIBLE(item.type)) { throw new Error("not a COLLECTIBLE type");

 }

 return COLLECTIBLE.reified( ).new( { dummyField: decodeFromFieldsWithTypes("bool", item.fields.dummy_field) } ) }

 static fromBcs( data: Uint8Array ): COLLECTIBLE { return COLLECTIBLE.fromFields( COLLECTIBLE.bcs.parse(data) ) }

 toJSONField() { return {

 dummyField: this.dummyField,

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): COLLECTIBLE { return COLLECTIBLE.reified( ).new( { dummyField: decodeFromJSONField("bool", field.dummyField) } ) }

 static fromJSON( json: Record<string, any> ): COLLECTIBLE { if (json.$typeName !== COLLECTIBLE.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return COLLECTIBLE.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): COLLECTIBLE { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isCOLLECTIBLE(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a COLLECTIBLE object`); } return COLLECTIBLE.fromFieldsWithTypes( content ); }

 static async fetch( client: SuiClient, id: string ): Promise<COLLECTIBLE> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching COLLECTIBLE object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isCOLLECTIBLE(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a COLLECTIBLE object`); }
 return COLLECTIBLE.fromBcs( fromB64(res.data.bcs.bcsBytes) ); }

 }

/* ============================== Collectible =============================== */

export function isCollectible(type: string): boolean { type = compressSuiType(type); return type.startsWith(`${PKG_V1}::collectible::Collectible` + '<'); }

export interface CollectibleFields<T extends TypeArgument> { id: ToField<UID>; imageUrl: ToField<String>; name: ToField<Option<String>>; description: ToField<Option<String>>; creator: ToField<Option<String>>; meta: ToField<Option<T>> }

export type CollectibleReified<T extends TypeArgument> = Reified< Collectible<T>, CollectibleFields<T> >;

export class Collectible<T extends TypeArgument> implements StructClass { static readonly $typeName = `${PKG_V1}::collectible::Collectible`; static readonly $numTypeParams = 1;

 readonly $typeName = Collectible.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::collectible::Collectible<${ToTypeStr<T>}>`;

 readonly $typeArgs: [ToTypeStr<T>];

 readonly id: ToField<UID>; readonly imageUrl: ToField<String>; readonly name: ToField<Option<String>>; readonly description: ToField<Option<String>>; readonly creator: ToField<Option<String>>; readonly meta: ToField<Option<T>>

 private constructor(typeArgs: [ToTypeStr<T>], fields: CollectibleFields<T>, ) { this.$fullTypeName = composeSuiType( Collectible.$typeName, ...typeArgs ) as `${typeof PKG_V1}::collectible::Collectible<${ToTypeStr<T>}>`; this.$typeArgs = typeArgs;

 this.id = fields.id;; this.imageUrl = fields.imageUrl;; this.name = fields.name;; this.description = fields.description;; this.creator = fields.creator;; this.meta = fields.meta; }

 static reified<T extends Reified<TypeArgument, any>>( T: T ): CollectibleReified<ToTypeArgument<T>> { return { typeName: Collectible.$typeName, fullTypeName: composeSuiType( Collectible.$typeName, ...[extractType(T)] ) as `${typeof PKG_V1}::collectible::Collectible<${ToTypeStr<ToTypeArgument<T>>}>`, typeArgs: [ extractType(T) ] as [ToTypeStr<ToTypeArgument<T>>], reifiedTypeArgs: [T], fromFields: (fields: Record<string, any>) => Collectible.fromFields( T, fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => Collectible.fromFieldsWithTypes( T, item, ), fromBcs: (data: Uint8Array) => Collectible.fromBcs( T, data, ), bcs: Collectible.bcs(toBcs(T)), fromJSONField: (field: any) => Collectible.fromJSONField( T, field, ), fromJSON: (json: Record<string, any>) => Collectible.fromJSON( T, json, ), fromSuiParsedData: (content: SuiParsedData) => Collectible.fromSuiParsedData( T, content, ), fetch: async (client: SuiClient, id: string) => Collectible.fetch( client, T, id, ), new: ( fields: CollectibleFields<ToTypeArgument<T>>, ) => { return new Collectible( [extractType(T)], fields ) }, kind: "StructClassReified", } }

 static get r() { return Collectible.reified }

 static phantom<T extends Reified<TypeArgument, any>>( T: T ): PhantomReified<ToTypeStr<Collectible<ToTypeArgument<T>>>> { return phantom(Collectible.reified( T )); } static get p() { return Collectible.phantom }

 static get bcs() { return <T extends BcsType<any>>(T: T) => bcs.struct(`Collectible<${T.name}>`, {

 id: UID.bcs, image_url: String.bcs, name: Option.bcs(String.bcs), description: Option.bcs(String.bcs), creator: Option.bcs(String.bcs), meta: Option.bcs(T)

}) };

 static fromFields<T extends Reified<TypeArgument, any>>( typeArg: T, fields: Record<string, any> ): Collectible<ToTypeArgument<T>> { return Collectible.reified( typeArg, ).new( { id: decodeFromFields(UID.reified(), fields.id), imageUrl: decodeFromFields(String.reified(), fields.image_url), name: decodeFromFields(Option.reified(String.reified()), fields.name), description: decodeFromFields(Option.reified(String.reified()), fields.description), creator: decodeFromFields(Option.reified(String.reified()), fields.creator), meta: decodeFromFields(Option.reified(typeArg), fields.meta) } ) }

 static fromFieldsWithTypes<T extends Reified<TypeArgument, any>>( typeArg: T, item: FieldsWithTypes ): Collectible<ToTypeArgument<T>> { if (!isCollectible(item.type)) { throw new Error("not a Collectible type");

 } assertFieldsWithTypesArgsMatch(item, [typeArg]);

 return Collectible.reified( typeArg, ).new( { id: decodeFromFieldsWithTypes(UID.reified(), item.fields.id), imageUrl: decodeFromFieldsWithTypes(String.reified(), item.fields.image_url), name: decodeFromFieldsWithTypes(Option.reified(String.reified()), item.fields.name), description: decodeFromFieldsWithTypes(Option.reified(String.reified()), item.fields.description), creator: decodeFromFieldsWithTypes(Option.reified(String.reified()), item.fields.creator), meta: decodeFromFieldsWithTypes(Option.reified(typeArg), item.fields.meta) } ) }

 static fromBcs<T extends Reified<TypeArgument, any>>( typeArg: T, data: Uint8Array ): Collectible<ToTypeArgument<T>> { const typeArgs = [typeArg];

 return Collectible.fromFields( typeArg, Collectible.bcs( toBcs(typeArgs[0]) ).parse(data) ) }

 toJSONField() { return {

 id: this.id,imageUrl: this.imageUrl,name: fieldToJSON<Option<String>>(`${Option.$typeName}<${String.$typeName}>`, this.name),description: fieldToJSON<Option<String>>(`${Option.$typeName}<${String.$typeName}>`, this.description),creator: fieldToJSON<Option<String>>(`${Option.$typeName}<${String.$typeName}>`, this.creator),meta: fieldToJSON<Option<T>>(`${Option.$typeName}<${this.$typeArgs[0]}>`, this.meta),

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField<T extends Reified<TypeArgument, any>>( typeArg: T, field: any ): Collectible<ToTypeArgument<T>> { return Collectible.reified( typeArg, ).new( { id: decodeFromJSONField(UID.reified(), field.id), imageUrl: decodeFromJSONField(String.reified(), field.imageUrl), name: decodeFromJSONField(Option.reified(String.reified()), field.name), description: decodeFromJSONField(Option.reified(String.reified()), field.description), creator: decodeFromJSONField(Option.reified(String.reified()), field.creator), meta: decodeFromJSONField(Option.reified(typeArg), field.meta) } ) }

 static fromJSON<T extends Reified<TypeArgument, any>>( typeArg: T, json: Record<string, any> ): Collectible<ToTypeArgument<T>> { if (json.$typeName !== Collectible.$typeName) { throw new Error("not a WithTwoGenerics json object") }; assertReifiedTypeArgsMatch( composeSuiType(Collectible.$typeName, extractType(typeArg)), json.$typeArgs, [typeArg], )

 return Collectible.fromJSONField( typeArg, json, ) }

 static fromSuiParsedData<T extends Reified<TypeArgument, any>>( typeArg: T, content: SuiParsedData ): Collectible<ToTypeArgument<T>> { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isCollectible(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a Collectible object`); } return Collectible.fromFieldsWithTypes( typeArg, content ); }

 static async fetch<T extends Reified<TypeArgument, any>>( client: SuiClient, typeArg: T, id: string ): Promise<Collectible<ToTypeArgument<T>>> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching Collectible object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isCollectible(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a Collectible object`); }
 return Collectible.fromBcs( typeArg, fromB64(res.data.bcs.bcsBytes) ); }

 }

/* ============================== CollectionCap =============================== */

export function isCollectionCap(type: string): boolean { type = compressSuiType(type); return type.startsWith(`${PKG_V1}::collectible::CollectionCap` + '<'); }

export interface CollectionCapFields<T extends TypeArgument> { id: ToField<UID>; publisher: ToField<Referent<Publisher>>; display: ToField<Referent<Display<ToPhantom<Collectible<T>>>>>; policyCap: ToField<Referent<TransferPolicyCap<ToPhantom<Collectible<T>>>>>; maxSupply: ToField<Option<"u32">>; minted: ToField<"u32">; burned: ToField<"u32"> }

export type CollectionCapReified<T extends TypeArgument> = Reified< CollectionCap<T>, CollectionCapFields<T> >;

export class CollectionCap<T extends TypeArgument> implements StructClass { static readonly $typeName = `${PKG_V1}::collectible::CollectionCap`; static readonly $numTypeParams = 1;

 readonly $typeName = CollectionCap.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::collectible::CollectionCap<${ToTypeStr<T>}>`;

 readonly $typeArgs: [ToTypeStr<T>];

 readonly id: ToField<UID>; readonly publisher: ToField<Referent<Publisher>>; readonly display: ToField<Referent<Display<ToPhantom<Collectible<T>>>>>; readonly policyCap: ToField<Referent<TransferPolicyCap<ToPhantom<Collectible<T>>>>>; readonly maxSupply: ToField<Option<"u32">>; readonly minted: ToField<"u32">; readonly burned: ToField<"u32">

 private constructor(typeArgs: [ToTypeStr<T>], fields: CollectionCapFields<T>, ) { this.$fullTypeName = composeSuiType( CollectionCap.$typeName, ...typeArgs ) as `${typeof PKG_V1}::collectible::CollectionCap<${ToTypeStr<T>}>`; this.$typeArgs = typeArgs;

 this.id = fields.id;; this.publisher = fields.publisher;; this.display = fields.display;; this.policyCap = fields.policyCap;; this.maxSupply = fields.maxSupply;; this.minted = fields.minted;; this.burned = fields.burned; }

 static reified<T extends Reified<TypeArgument, any>>( T: T ): CollectionCapReified<ToTypeArgument<T>> { return { typeName: CollectionCap.$typeName, fullTypeName: composeSuiType( CollectionCap.$typeName, ...[extractType(T)] ) as `${typeof PKG_V1}::collectible::CollectionCap<${ToTypeStr<ToTypeArgument<T>>}>`, typeArgs: [ extractType(T) ] as [ToTypeStr<ToTypeArgument<T>>], reifiedTypeArgs: [T], fromFields: (fields: Record<string, any>) => CollectionCap.fromFields( T, fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => CollectionCap.fromFieldsWithTypes( T, item, ), fromBcs: (data: Uint8Array) => CollectionCap.fromBcs( T, data, ), bcs: CollectionCap.bcs(toBcs(T)), fromJSONField: (field: any) => CollectionCap.fromJSONField( T, field, ), fromJSON: (json: Record<string, any>) => CollectionCap.fromJSON( T, json, ), fromSuiParsedData: (content: SuiParsedData) => CollectionCap.fromSuiParsedData( T, content, ), fetch: async (client: SuiClient, id: string) => CollectionCap.fetch( client, T, id, ), new: ( fields: CollectionCapFields<ToTypeArgument<T>>, ) => { return new CollectionCap( [extractType(T)], fields ) }, kind: "StructClassReified", } }

 static get r() { return CollectionCap.reified }

 static phantom<T extends Reified<TypeArgument, any>>( T: T ): PhantomReified<ToTypeStr<CollectionCap<ToTypeArgument<T>>>> { return phantom(CollectionCap.reified( T )); } static get p() { return CollectionCap.phantom }

 static get bcs() { return <T extends BcsType<any>>(T: T) => bcs.struct(`CollectionCap<${T.name}>`, {

 id: UID.bcs, publisher: Referent.bcs(Publisher.bcs), display: Referent.bcs(Display.bcs), policy_cap: Referent.bcs(TransferPolicyCap.bcs), max_supply: Option.bcs(bcs.u32()), minted: bcs.u32(), burned: bcs.u32()

}) };

 static fromFields<T extends Reified<TypeArgument, any>>( typeArg: T, fields: Record<string, any> ): CollectionCap<ToTypeArgument<T>> { return CollectionCap.reified( typeArg, ).new( { id: decodeFromFields(UID.reified(), fields.id), publisher: decodeFromFields(Referent.reified(Publisher.reified()), fields.publisher), display: decodeFromFields(Referent.reified(Display.reified(reified.phantom(Collectible.reified(typeArg)))), fields.display), policyCap: decodeFromFields(Referent.reified(TransferPolicyCap.reified(reified.phantom(Collectible.reified(typeArg)))), fields.policy_cap), maxSupply: decodeFromFields(Option.reified("u32"), fields.max_supply), minted: decodeFromFields("u32", fields.minted), burned: decodeFromFields("u32", fields.burned) } ) }

 static fromFieldsWithTypes<T extends Reified<TypeArgument, any>>( typeArg: T, item: FieldsWithTypes ): CollectionCap<ToTypeArgument<T>> { if (!isCollectionCap(item.type)) { throw new Error("not a CollectionCap type");

 } assertFieldsWithTypesArgsMatch(item, [typeArg]);

 return CollectionCap.reified( typeArg, ).new( { id: decodeFromFieldsWithTypes(UID.reified(), item.fields.id), publisher: decodeFromFieldsWithTypes(Referent.reified(Publisher.reified()), item.fields.publisher), display: decodeFromFieldsWithTypes(Referent.reified(Display.reified(reified.phantom(Collectible.reified(typeArg)))), item.fields.display), policyCap: decodeFromFieldsWithTypes(Referent.reified(TransferPolicyCap.reified(reified.phantom(Collectible.reified(typeArg)))), item.fields.policy_cap), maxSupply: decodeFromFieldsWithTypes(Option.reified("u32"), item.fields.max_supply), minted: decodeFromFieldsWithTypes("u32", item.fields.minted), burned: decodeFromFieldsWithTypes("u32", item.fields.burned) } ) }

 static fromBcs<T extends Reified<TypeArgument, any>>( typeArg: T, data: Uint8Array ): CollectionCap<ToTypeArgument<T>> { const typeArgs = [typeArg];

 return CollectionCap.fromFields( typeArg, CollectionCap.bcs( toBcs(typeArgs[0]) ).parse(data) ) }

 toJSONField() { return {

 id: this.id,publisher: this.publisher.toJSONField(),display: this.display.toJSONField(),policyCap: this.policyCap.toJSONField(),maxSupply: fieldToJSON<Option<"u32">>(`${Option.$typeName}<u32>`, this.maxSupply),minted: this.minted,burned: this.burned,

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField<T extends Reified<TypeArgument, any>>( typeArg: T, field: any ): CollectionCap<ToTypeArgument<T>> { return CollectionCap.reified( typeArg, ).new( { id: decodeFromJSONField(UID.reified(), field.id), publisher: decodeFromJSONField(Referent.reified(Publisher.reified()), field.publisher), display: decodeFromJSONField(Referent.reified(Display.reified(reified.phantom(Collectible.reified(typeArg)))), field.display), policyCap: decodeFromJSONField(Referent.reified(TransferPolicyCap.reified(reified.phantom(Collectible.reified(typeArg)))), field.policyCap), maxSupply: decodeFromJSONField(Option.reified("u32"), field.maxSupply), minted: decodeFromJSONField("u32", field.minted), burned: decodeFromJSONField("u32", field.burned) } ) }

 static fromJSON<T extends Reified<TypeArgument, any>>( typeArg: T, json: Record<string, any> ): CollectionCap<ToTypeArgument<T>> { if (json.$typeName !== CollectionCap.$typeName) { throw new Error("not a WithTwoGenerics json object") }; assertReifiedTypeArgsMatch( composeSuiType(CollectionCap.$typeName, extractType(typeArg)), json.$typeArgs, [typeArg], )

 return CollectionCap.fromJSONField( typeArg, json, ) }

 static fromSuiParsedData<T extends Reified<TypeArgument, any>>( typeArg: T, content: SuiParsedData ): CollectionCap<ToTypeArgument<T>> { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isCollectionCap(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a CollectionCap object`); } return CollectionCap.fromFieldsWithTypes( typeArg, content ); }

 static async fetch<T extends Reified<TypeArgument, any>>( client: SuiClient, typeArg: T, id: string ): Promise<CollectionCap<ToTypeArgument<T>>> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching CollectionCap object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isCollectionCap(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a CollectionCap object`); }
 return CollectionCap.fromBcs( typeArg, fromB64(res.data.bcs.bcsBytes) ); }

 }

/* ============================== CollectionTicket =============================== */

export function isCollectionTicket(type: string): boolean { type = compressSuiType(type); return type.startsWith(`${PKG_V1}::collectible::CollectionTicket` + '<'); }

export interface CollectionTicketFields<T extends PhantomTypeArgument> { id: ToField<UID>; publisher: ToField<Publisher>; maxSupply: ToField<Option<"u32">> }

export type CollectionTicketReified<T extends PhantomTypeArgument> = Reified< CollectionTicket<T>, CollectionTicketFields<T> >;

export class CollectionTicket<T extends PhantomTypeArgument> implements StructClass { static readonly $typeName = `${PKG_V1}::collectible::CollectionTicket`; static readonly $numTypeParams = 1;

 readonly $typeName = CollectionTicket.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::collectible::CollectionTicket<${PhantomToTypeStr<T>}>`;

 readonly $typeArgs: [PhantomToTypeStr<T>];

 readonly id: ToField<UID>; readonly publisher: ToField<Publisher>; readonly maxSupply: ToField<Option<"u32">>

 private constructor(typeArgs: [PhantomToTypeStr<T>], fields: CollectionTicketFields<T>, ) { this.$fullTypeName = composeSuiType( CollectionTicket.$typeName, ...typeArgs ) as `${typeof PKG_V1}::collectible::CollectionTicket<${PhantomToTypeStr<T>}>`; this.$typeArgs = typeArgs;

 this.id = fields.id;; this.publisher = fields.publisher;; this.maxSupply = fields.maxSupply; }

 static reified<T extends PhantomReified<PhantomTypeArgument>>( T: T ): CollectionTicketReified<ToPhantomTypeArgument<T>> { return { typeName: CollectionTicket.$typeName, fullTypeName: composeSuiType( CollectionTicket.$typeName, ...[extractType(T)] ) as `${typeof PKG_V1}::collectible::CollectionTicket<${PhantomToTypeStr<ToPhantomTypeArgument<T>>}>`, typeArgs: [ extractType(T) ] as [PhantomToTypeStr<ToPhantomTypeArgument<T>>], reifiedTypeArgs: [T], fromFields: (fields: Record<string, any>) => CollectionTicket.fromFields( T, fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => CollectionTicket.fromFieldsWithTypes( T, item, ), fromBcs: (data: Uint8Array) => CollectionTicket.fromBcs( T, data, ), bcs: CollectionTicket.bcs, fromJSONField: (field: any) => CollectionTicket.fromJSONField( T, field, ), fromJSON: (json: Record<string, any>) => CollectionTicket.fromJSON( T, json, ), fromSuiParsedData: (content: SuiParsedData) => CollectionTicket.fromSuiParsedData( T, content, ), fetch: async (client: SuiClient, id: string) => CollectionTicket.fetch( client, T, id, ), new: ( fields: CollectionTicketFields<ToPhantomTypeArgument<T>>, ) => { return new CollectionTicket( [extractType(T)], fields ) }, kind: "StructClassReified", } }

 static get r() { return CollectionTicket.reified }

 static phantom<T extends PhantomReified<PhantomTypeArgument>>( T: T ): PhantomReified<ToTypeStr<CollectionTicket<ToPhantomTypeArgument<T>>>> { return phantom(CollectionTicket.reified( T )); } static get p() { return CollectionTicket.phantom }

 static get bcs() { return bcs.struct("CollectionTicket", {

 id: UID.bcs, publisher: Publisher.bcs, max_supply: Option.bcs(bcs.u32())

}) };

 static fromFields<T extends PhantomReified<PhantomTypeArgument>>( typeArg: T, fields: Record<string, any> ): CollectionTicket<ToPhantomTypeArgument<T>> { return CollectionTicket.reified( typeArg, ).new( { id: decodeFromFields(UID.reified(), fields.id), publisher: decodeFromFields(Publisher.reified(), fields.publisher), maxSupply: decodeFromFields(Option.reified("u32"), fields.max_supply) } ) }

 static fromFieldsWithTypes<T extends PhantomReified<PhantomTypeArgument>>( typeArg: T, item: FieldsWithTypes ): CollectionTicket<ToPhantomTypeArgument<T>> { if (!isCollectionTicket(item.type)) { throw new Error("not a CollectionTicket type");

 } assertFieldsWithTypesArgsMatch(item, [typeArg]);

 return CollectionTicket.reified( typeArg, ).new( { id: decodeFromFieldsWithTypes(UID.reified(), item.fields.id), publisher: decodeFromFieldsWithTypes(Publisher.reified(), item.fields.publisher), maxSupply: decodeFromFieldsWithTypes(Option.reified("u32"), item.fields.max_supply) } ) }

 static fromBcs<T extends PhantomReified<PhantomTypeArgument>>( typeArg: T, data: Uint8Array ): CollectionTicket<ToPhantomTypeArgument<T>> { return CollectionTicket.fromFields( typeArg, CollectionTicket.bcs.parse(data) ) }

 toJSONField() { return {

 id: this.id,publisher: this.publisher.toJSONField(),maxSupply: fieldToJSON<Option<"u32">>(`${Option.$typeName}<u32>`, this.maxSupply),

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField<T extends PhantomReified<PhantomTypeArgument>>( typeArg: T, field: any ): CollectionTicket<ToPhantomTypeArgument<T>> { return CollectionTicket.reified( typeArg, ).new( { id: decodeFromJSONField(UID.reified(), field.id), publisher: decodeFromJSONField(Publisher.reified(), field.publisher), maxSupply: decodeFromJSONField(Option.reified("u32"), field.maxSupply) } ) }

 static fromJSON<T extends PhantomReified<PhantomTypeArgument>>( typeArg: T, json: Record<string, any> ): CollectionTicket<ToPhantomTypeArgument<T>> { if (json.$typeName !== CollectionTicket.$typeName) { throw new Error("not a WithTwoGenerics json object") }; assertReifiedTypeArgsMatch( composeSuiType(CollectionTicket.$typeName, extractType(typeArg)), json.$typeArgs, [typeArg], )

 return CollectionTicket.fromJSONField( typeArg, json, ) }

 static fromSuiParsedData<T extends PhantomReified<PhantomTypeArgument>>( typeArg: T, content: SuiParsedData ): CollectionTicket<ToPhantomTypeArgument<T>> { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isCollectionTicket(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a CollectionTicket object`); } return CollectionTicket.fromFieldsWithTypes( typeArg, content ); }

 static async fetch<T extends PhantomReified<PhantomTypeArgument>>( client: SuiClient, typeArg: T, id: string ): Promise<CollectionTicket<ToPhantomTypeArgument<T>>> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching CollectionTicket object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isCollectionTicket(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a CollectionTicket object`); }
 return CollectionTicket.fromBcs( typeArg, fromB64(res.data.bcs.bcsBytes) ); }

 }
