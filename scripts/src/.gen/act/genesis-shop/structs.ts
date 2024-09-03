import * as reified from "../../_framework/reified";
import {String} from "../../_dependencies/source/0x1/string/structs";
import {UID} from "../../_dependencies/source/0x2/object/structs";
import {TableVec} from "../../_dependencies/source/0x2/table-vec/structs";
import {Table} from "../../_dependencies/source/0x2/table/structs";
import {PhantomReified, Reified, StructClass, ToField, ToTypeStr, decodeFromFields, decodeFromFieldsWithTypes, decodeFromJSONField, fieldToJSON, phantom, ToTypeStr as ToPhantom} from "../../_framework/reified";
import {FieldsWithTypes, composeSuiType, compressSuiType} from "../../_framework/util";
import {Vector} from "../../_framework/vector";
import {PKG_V1} from "../index";
import {bcs} from "@mysten/sui/bcs";
import {SuiClient, SuiObjectData, SuiParsedData} from "@mysten/sui/client";
import {fromB64} from "@mysten/sui/utils";

/* ============================== Item =============================== */

export function isItem(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::genesis_shop::Item`; }

export interface ItemFields { hash: ToField<Vector<"u8">>; name: ToField<String>; equipment: ToField<String>; colourWay: ToField<String>; manufacturer: ToField<String>; rarity: ToField<String>; imageUrl: ToField<String>; modelUrl: ToField<String>; textureUrl: ToField<String> }

export type ItemReified = Reified< Item, ItemFields >;

export class Item implements StructClass { __StructClass = true as const;

 static readonly $typeName = `${PKG_V1}::genesis_shop::Item`; static readonly $numTypeParams = 0; static readonly $isPhantom = [] as const;

 readonly $typeName = Item.$typeName; readonly $fullTypeName: `${typeof PKG_V1}::genesis_shop::Item`; readonly $typeArgs: []; readonly $isPhantom = Item.$isPhantom;

 readonly hash: ToField<Vector<"u8">>; readonly name: ToField<String>; readonly equipment: ToField<String>; readonly colourWay: ToField<String>; readonly manufacturer: ToField<String>; readonly rarity: ToField<String>; readonly imageUrl: ToField<String>; readonly modelUrl: ToField<String>; readonly textureUrl: ToField<String>

 private constructor(typeArgs: [], fields: ItemFields, ) { this.$fullTypeName = composeSuiType( Item.$typeName, ...typeArgs ) as `${typeof PKG_V1}::genesis_shop::Item`; this.$typeArgs = typeArgs;

 this.hash = fields.hash;; this.name = fields.name;; this.equipment = fields.equipment;; this.colourWay = fields.colourWay;; this.manufacturer = fields.manufacturer;; this.rarity = fields.rarity;; this.imageUrl = fields.imageUrl;; this.modelUrl = fields.modelUrl;; this.textureUrl = fields.textureUrl; }

 static reified( ): ItemReified { return { typeName: Item.$typeName, fullTypeName: composeSuiType( Item.$typeName, ...[] ) as `${typeof PKG_V1}::genesis_shop::Item`, typeArgs: [ ] as [], isPhantom: Item.$isPhantom, reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => Item.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => Item.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => Item.fromBcs( data, ), bcs: Item.bcs, fromJSONField: (field: any) => Item.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => Item.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => Item.fromSuiParsedData( content, ), fromSuiObjectData: (content: SuiObjectData) => Item.fromSuiObjectData( content, ), fetch: async (client: SuiClient, id: string) => Item.fetch( client, id, ), new: ( fields: ItemFields, ) => { return new Item( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return Item.reified() }

 static phantom( ): PhantomReified<ToTypeStr<Item>> { return phantom(Item.reified( )); } static get p() { return Item.phantom() }

 static get bcs() { return bcs.struct("Item", {

 hash: bcs.vector(bcs.u8()), name: String.bcs, equipment: String.bcs, colour_way: String.bcs, manufacturer: String.bcs, rarity: String.bcs, image_url: String.bcs, model_url: String.bcs, texture_url: String.bcs

}) };

 static fromFields( fields: Record<string, any> ): Item { return Item.reified( ).new( { hash: decodeFromFields(reified.vector("u8"), fields.hash), name: decodeFromFields(String.reified(), fields.name), equipment: decodeFromFields(String.reified(), fields.equipment), colourWay: decodeFromFields(String.reified(), fields.colour_way), manufacturer: decodeFromFields(String.reified(), fields.manufacturer), rarity: decodeFromFields(String.reified(), fields.rarity), imageUrl: decodeFromFields(String.reified(), fields.image_url), modelUrl: decodeFromFields(String.reified(), fields.model_url), textureUrl: decodeFromFields(String.reified(), fields.texture_url) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): Item { if (!isItem(item.type)) { throw new Error("not a Item type");

 }

 return Item.reified( ).new( { hash: decodeFromFieldsWithTypes(reified.vector("u8"), item.fields.hash), name: decodeFromFieldsWithTypes(String.reified(), item.fields.name), equipment: decodeFromFieldsWithTypes(String.reified(), item.fields.equipment), colourWay: decodeFromFieldsWithTypes(String.reified(), item.fields.colour_way), manufacturer: decodeFromFieldsWithTypes(String.reified(), item.fields.manufacturer), rarity: decodeFromFieldsWithTypes(String.reified(), item.fields.rarity), imageUrl: decodeFromFieldsWithTypes(String.reified(), item.fields.image_url), modelUrl: decodeFromFieldsWithTypes(String.reified(), item.fields.model_url), textureUrl: decodeFromFieldsWithTypes(String.reified(), item.fields.texture_url) } ) }

 static fromBcs( data: Uint8Array ): Item { return Item.fromFields( Item.bcs.parse(data) ) }

 toJSONField() { return {

 hash: fieldToJSON<Vector<"u8">>(`vector<u8>`, this.hash),name: this.name,equipment: this.equipment,colourWay: this.colourWay,manufacturer: this.manufacturer,rarity: this.rarity,imageUrl: this.imageUrl,modelUrl: this.modelUrl,textureUrl: this.textureUrl,

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): Item { return Item.reified( ).new( { hash: decodeFromJSONField(reified.vector("u8"), field.hash), name: decodeFromJSONField(String.reified(), field.name), equipment: decodeFromJSONField(String.reified(), field.equipment), colourWay: decodeFromJSONField(String.reified(), field.colourWay), manufacturer: decodeFromJSONField(String.reified(), field.manufacturer), rarity: decodeFromJSONField(String.reified(), field.rarity), imageUrl: decodeFromJSONField(String.reified(), field.imageUrl), modelUrl: decodeFromJSONField(String.reified(), field.modelUrl), textureUrl: decodeFromJSONField(String.reified(), field.textureUrl) } ) }

 static fromJSON( json: Record<string, any> ): Item { if (json.$typeName !== Item.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return Item.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): Item { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isItem(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a Item object`); } return Item.fromFieldsWithTypes( content ); }

 static fromSuiObjectData( data: SuiObjectData ): Item { if (data.bcs) { if (data.bcs.dataType !== "moveObject" || !isItem(data.bcs.type)) { throw new Error(`object at is not a Item object`); }

 return Item.fromBcs( fromB64(data.bcs.bcsBytes) ); } if (data.content) { return Item.fromSuiParsedData( data.content ) } throw new Error( "Both `bcs` and `content` fields are missing from the data. Include `showBcs` or `showContent` in the request." ); }

 static async fetch( client: SuiClient, id: string ): Promise<Item> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching Item object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isItem(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a Item object`); }

 return Item.fromSuiObjectData( res.data ); }

 }

/* ============================== Builder =============================== */

export function isBuilder(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::genesis_shop::Builder`; }

export interface BuilderFields { id: ToField<UID>; equipment: ToField<Vector<"u8">>; names: ToField<Vector<Vector<"u8">>>; colourWays: ToField<Vector<Vector<"u8">>>; manufacturers: ToField<Vector<Vector<"u8">>>; rarities: ToField<Vector<Vector<"u8">>>; quantities: ToField<Vector<Vector<"u64">>> }

export type BuilderReified = Reified< Builder, BuilderFields >;

export class Builder implements StructClass { __StructClass = true as const;

 static readonly $typeName = `${PKG_V1}::genesis_shop::Builder`; static readonly $numTypeParams = 0; static readonly $isPhantom = [] as const;

 readonly $typeName = Builder.$typeName; readonly $fullTypeName: `${typeof PKG_V1}::genesis_shop::Builder`; readonly $typeArgs: []; readonly $isPhantom = Builder.$isPhantom;

 readonly id: ToField<UID>; readonly equipment: ToField<Vector<"u8">>; readonly names: ToField<Vector<Vector<"u8">>>; readonly colourWays: ToField<Vector<Vector<"u8">>>; readonly manufacturers: ToField<Vector<Vector<"u8">>>; readonly rarities: ToField<Vector<Vector<"u8">>>; readonly quantities: ToField<Vector<Vector<"u64">>>

 private constructor(typeArgs: [], fields: BuilderFields, ) { this.$fullTypeName = composeSuiType( Builder.$typeName, ...typeArgs ) as `${typeof PKG_V1}::genesis_shop::Builder`; this.$typeArgs = typeArgs;

 this.id = fields.id;; this.equipment = fields.equipment;; this.names = fields.names;; this.colourWays = fields.colourWays;; this.manufacturers = fields.manufacturers;; this.rarities = fields.rarities;; this.quantities = fields.quantities; }

 static reified( ): BuilderReified { return { typeName: Builder.$typeName, fullTypeName: composeSuiType( Builder.$typeName, ...[] ) as `${typeof PKG_V1}::genesis_shop::Builder`, typeArgs: [ ] as [], isPhantom: Builder.$isPhantom, reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => Builder.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => Builder.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => Builder.fromBcs( data, ), bcs: Builder.bcs, fromJSONField: (field: any) => Builder.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => Builder.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => Builder.fromSuiParsedData( content, ), fromSuiObjectData: (content: SuiObjectData) => Builder.fromSuiObjectData( content, ), fetch: async (client: SuiClient, id: string) => Builder.fetch( client, id, ), new: ( fields: BuilderFields, ) => { return new Builder( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return Builder.reified() }

 static phantom( ): PhantomReified<ToTypeStr<Builder>> { return phantom(Builder.reified( )); } static get p() { return Builder.phantom() }

 static get bcs() { return bcs.struct("Builder", {

 id: UID.bcs, equipment: bcs.vector(bcs.u8()), names: bcs.vector(bcs.vector(bcs.u8())), colour_ways: bcs.vector(bcs.vector(bcs.u8())), manufacturers: bcs.vector(bcs.vector(bcs.u8())), rarities: bcs.vector(bcs.vector(bcs.u8())), quantities: bcs.vector(bcs.vector(bcs.u64()))

}) };

 static fromFields( fields: Record<string, any> ): Builder { return Builder.reified( ).new( { id: decodeFromFields(UID.reified(), fields.id), equipment: decodeFromFields(reified.vector("u8"), fields.equipment), names: decodeFromFields(reified.vector(reified.vector("u8")), fields.names), colourWays: decodeFromFields(reified.vector(reified.vector("u8")), fields.colour_ways), manufacturers: decodeFromFields(reified.vector(reified.vector("u8")), fields.manufacturers), rarities: decodeFromFields(reified.vector(reified.vector("u8")), fields.rarities), quantities: decodeFromFields(reified.vector(reified.vector("u64")), fields.quantities) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): Builder { if (!isBuilder(item.type)) { throw new Error("not a Builder type");

 }

 return Builder.reified( ).new( { id: decodeFromFieldsWithTypes(UID.reified(), item.fields.id), equipment: decodeFromFieldsWithTypes(reified.vector("u8"), item.fields.equipment), names: decodeFromFieldsWithTypes(reified.vector(reified.vector("u8")), item.fields.names), colourWays: decodeFromFieldsWithTypes(reified.vector(reified.vector("u8")), item.fields.colour_ways), manufacturers: decodeFromFieldsWithTypes(reified.vector(reified.vector("u8")), item.fields.manufacturers), rarities: decodeFromFieldsWithTypes(reified.vector(reified.vector("u8")), item.fields.rarities), quantities: decodeFromFieldsWithTypes(reified.vector(reified.vector("u64")), item.fields.quantities) } ) }

 static fromBcs( data: Uint8Array ): Builder { return Builder.fromFields( Builder.bcs.parse(data) ) }

 toJSONField() { return {

 id: this.id,equipment: fieldToJSON<Vector<"u8">>(`vector<u8>`, this.equipment),names: fieldToJSON<Vector<Vector<"u8">>>(`vector<vector<u8>>`, this.names),colourWays: fieldToJSON<Vector<Vector<"u8">>>(`vector<vector<u8>>`, this.colourWays),manufacturers: fieldToJSON<Vector<Vector<"u8">>>(`vector<vector<u8>>`, this.manufacturers),rarities: fieldToJSON<Vector<Vector<"u8">>>(`vector<vector<u8>>`, this.rarities),quantities: fieldToJSON<Vector<Vector<"u64">>>(`vector<vector<u64>>`, this.quantities),

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): Builder { return Builder.reified( ).new( { id: decodeFromJSONField(UID.reified(), field.id), equipment: decodeFromJSONField(reified.vector("u8"), field.equipment), names: decodeFromJSONField(reified.vector(reified.vector("u8")), field.names), colourWays: decodeFromJSONField(reified.vector(reified.vector("u8")), field.colourWays), manufacturers: decodeFromJSONField(reified.vector(reified.vector("u8")), field.manufacturers), rarities: decodeFromJSONField(reified.vector(reified.vector("u8")), field.rarities), quantities: decodeFromJSONField(reified.vector(reified.vector("u64")), field.quantities) } ) }

 static fromJSON( json: Record<string, any> ): Builder { if (json.$typeName !== Builder.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return Builder.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): Builder { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isBuilder(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a Builder object`); } return Builder.fromFieldsWithTypes( content ); }

 static fromSuiObjectData( data: SuiObjectData ): Builder { if (data.bcs) { if (data.bcs.dataType !== "moveObject" || !isBuilder(data.bcs.type)) { throw new Error(`object at is not a Builder object`); }

 return Builder.fromBcs( fromB64(data.bcs.bcsBytes) ); } if (data.content) { return Builder.fromSuiParsedData( data.content ) } throw new Error( "Both `bcs` and `content` fields are missing from the data. Include `showBcs` or `showContent` in the request." ); }

 static async fetch( client: SuiClient, id: string ): Promise<Builder> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching Builder object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isBuilder(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a Builder object`); }

 return Builder.fromSuiObjectData( res.data ); }

 }

/* ============================== GenesisShop =============================== */

export function isGenesisShop(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::genesis_shop::GenesisShop`; }

export interface GenesisShopFields { id: ToField<UID>; items: ToField<Table<ToPhantom<String>, ToPhantom<TableVec<ToPhantom<Item>>>>> }

export type GenesisShopReified = Reified< GenesisShop, GenesisShopFields >;

export class GenesisShop implements StructClass { __StructClass = true as const;

 static readonly $typeName = `${PKG_V1}::genesis_shop::GenesisShop`; static readonly $numTypeParams = 0; static readonly $isPhantom = [] as const;

 readonly $typeName = GenesisShop.$typeName; readonly $fullTypeName: `${typeof PKG_V1}::genesis_shop::GenesisShop`; readonly $typeArgs: []; readonly $isPhantom = GenesisShop.$isPhantom;

 readonly id: ToField<UID>; readonly items: ToField<Table<ToPhantom<String>, ToPhantom<TableVec<ToPhantom<Item>>>>>

 private constructor(typeArgs: [], fields: GenesisShopFields, ) { this.$fullTypeName = composeSuiType( GenesisShop.$typeName, ...typeArgs ) as `${typeof PKG_V1}::genesis_shop::GenesisShop`; this.$typeArgs = typeArgs;

 this.id = fields.id;; this.items = fields.items; }

 static reified( ): GenesisShopReified { return { typeName: GenesisShop.$typeName, fullTypeName: composeSuiType( GenesisShop.$typeName, ...[] ) as `${typeof PKG_V1}::genesis_shop::GenesisShop`, typeArgs: [ ] as [], isPhantom: GenesisShop.$isPhantom, reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => GenesisShop.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => GenesisShop.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => GenesisShop.fromBcs( data, ), bcs: GenesisShop.bcs, fromJSONField: (field: any) => GenesisShop.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => GenesisShop.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => GenesisShop.fromSuiParsedData( content, ), fromSuiObjectData: (content: SuiObjectData) => GenesisShop.fromSuiObjectData( content, ), fetch: async (client: SuiClient, id: string) => GenesisShop.fetch( client, id, ), new: ( fields: GenesisShopFields, ) => { return new GenesisShop( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return GenesisShop.reified() }

 static phantom( ): PhantomReified<ToTypeStr<GenesisShop>> { return phantom(GenesisShop.reified( )); } static get p() { return GenesisShop.phantom() }

 static get bcs() { return bcs.struct("GenesisShop", {

 id: UID.bcs, items: Table.bcs

}) };

 static fromFields( fields: Record<string, any> ): GenesisShop { return GenesisShop.reified( ).new( { id: decodeFromFields(UID.reified(), fields.id), items: decodeFromFields(Table.reified(reified.phantom(String.reified()), reified.phantom(TableVec.reified(reified.phantom(Item.reified())))), fields.items) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): GenesisShop { if (!isGenesisShop(item.type)) { throw new Error("not a GenesisShop type");

 }

 return GenesisShop.reified( ).new( { id: decodeFromFieldsWithTypes(UID.reified(), item.fields.id), items: decodeFromFieldsWithTypes(Table.reified(reified.phantom(String.reified()), reified.phantom(TableVec.reified(reified.phantom(Item.reified())))), item.fields.items) } ) }

 static fromBcs( data: Uint8Array ): GenesisShop { return GenesisShop.fromFields( GenesisShop.bcs.parse(data) ) }

 toJSONField() { return {

 id: this.id,items: this.items.toJSONField(),

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): GenesisShop { return GenesisShop.reified( ).new( { id: decodeFromJSONField(UID.reified(), field.id), items: decodeFromJSONField(Table.reified(reified.phantom(String.reified()), reified.phantom(TableVec.reified(reified.phantom(Item.reified())))), field.items) } ) }

 static fromJSON( json: Record<string, any> ): GenesisShop { if (json.$typeName !== GenesisShop.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return GenesisShop.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): GenesisShop { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isGenesisShop(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a GenesisShop object`); } return GenesisShop.fromFieldsWithTypes( content ); }

 static fromSuiObjectData( data: SuiObjectData ): GenesisShop { if (data.bcs) { if (data.bcs.dataType !== "moveObject" || !isGenesisShop(data.bcs.type)) { throw new Error(`object at is not a GenesisShop object`); }

 return GenesisShop.fromBcs( fromB64(data.bcs.bcsBytes) ); } if (data.content) { return GenesisShop.fromSuiParsedData( data.content ) } throw new Error( "Both `bcs` and `content` fields are missing from the data. Include `showBcs` or `showContent` in the request." ); }

 static async fetch( client: SuiClient, id: string ): Promise<GenesisShop> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching GenesisShop object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isGenesisShop(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a GenesisShop object`); }

 return GenesisShop.fromSuiObjectData( res.data ); }

 }
