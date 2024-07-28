import * as reified from "../../_framework/reified";
import {String} from "../../_dependencies/source/0x1/string/structs";
import {UID} from "../../_dependencies/source/0x2/object/structs";
import {TableVec} from "../../_dependencies/source/0x2/table-vec/structs";
import {Table} from "../../_dependencies/source/0x2/table/structs";
import {PhantomReified, Reified, StructClass, ToField, ToTypeStr, Vector, decodeFromFields, decodeFromFieldsWithTypes, decodeFromJSONField, fieldToJSON, phantom, ToTypeStr as ToPhantom} from "../../_framework/reified";
import {FieldsWithTypes, composeSuiType, compressSuiType} from "../../_framework/util";
import {PKG_V1} from "../index";
import {bcs, fromB64} from "@mysten/bcs";
import {SuiClient, SuiParsedData} from "@mysten/sui/client";

/* ============================== Item =============================== */

export function isItem(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::genesis_shop::Item`; }

export interface ItemFields { name: ToField<String>; kinds: ToField<Vector<String>>; isCosmetic: ToField<"bool">; colourWay: ToField<String>; manufacturer: ToField<String>; rarity: ToField<String> }

export type ItemReified = Reified< Item, ItemFields >;

export class Item implements StructClass { static readonly $typeName = `${PKG_V1}::genesis_shop::Item`; static readonly $numTypeParams = 0;

 readonly $typeName = Item.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::genesis_shop::Item`;

 readonly $typeArgs: [];

 readonly name: ToField<String>; readonly kinds: ToField<Vector<String>>; readonly isCosmetic: ToField<"bool">; readonly colourWay: ToField<String>; readonly manufacturer: ToField<String>; readonly rarity: ToField<String>

 private constructor(typeArgs: [], fields: ItemFields, ) { this.$fullTypeName = composeSuiType( Item.$typeName, ...typeArgs ) as `${typeof PKG_V1}::genesis_shop::Item`; this.$typeArgs = typeArgs;

 this.name = fields.name;; this.kinds = fields.kinds;; this.isCosmetic = fields.isCosmetic;; this.colourWay = fields.colourWay;; this.manufacturer = fields.manufacturer;; this.rarity = fields.rarity; }

 static reified( ): ItemReified { return { typeName: Item.$typeName, fullTypeName: composeSuiType( Item.$typeName, ...[] ) as `${typeof PKG_V1}::genesis_shop::Item`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => Item.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => Item.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => Item.fromBcs( data, ), bcs: Item.bcs, fromJSONField: (field: any) => Item.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => Item.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => Item.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => Item.fetch( client, id, ), new: ( fields: ItemFields, ) => { return new Item( [], fields ) }, kind: "StructClassReified", } }

 static get r() { return Item.reified() }

 static phantom( ): PhantomReified<ToTypeStr<Item>> { return phantom(Item.reified( )); } static get p() { return Item.phantom() }

 static get bcs() { return bcs.struct("Item", {

 name: String.bcs, kinds: bcs.vector(String.bcs), is_cosmetic: bcs.bool(), colour_way: String.bcs, manufacturer: String.bcs, rarity: String.bcs

}) };

 static fromFields( fields: Record<string, any> ): Item { return Item.reified( ).new( { name: decodeFromFields(String.reified(), fields.name), kinds: decodeFromFields(reified.vector(String.reified()), fields.kinds), isCosmetic: decodeFromFields("bool", fields.is_cosmetic), colourWay: decodeFromFields(String.reified(), fields.colour_way), manufacturer: decodeFromFields(String.reified(), fields.manufacturer), rarity: decodeFromFields(String.reified(), fields.rarity) } ) }

 static fromFieldsWithTypes( item: FieldsWithTypes ): Item { if (!isItem(item.type)) { throw new Error("not a Item type");

 }

 return Item.reified( ).new( { name: decodeFromFieldsWithTypes(String.reified(), item.fields.name), kinds: decodeFromFieldsWithTypes(reified.vector(String.reified()), item.fields.kinds), isCosmetic: decodeFromFieldsWithTypes("bool", item.fields.is_cosmetic), colourWay: decodeFromFieldsWithTypes(String.reified(), item.fields.colour_way), manufacturer: decodeFromFieldsWithTypes(String.reified(), item.fields.manufacturer), rarity: decodeFromFieldsWithTypes(String.reified(), item.fields.rarity) } ) }

 static fromBcs( data: Uint8Array ): Item { return Item.fromFields( Item.bcs.parse(data) ) }

 toJSONField() { return {

 name: this.name,kinds: fieldToJSON<Vector<String>>(`vector<${String.$typeName}>`, this.kinds),isCosmetic: this.isCosmetic,colourWay: this.colourWay,manufacturer: this.manufacturer,rarity: this.rarity,

} }

 toJSON() { return { $typeName: this.$typeName, $typeArgs: this.$typeArgs, ...this.toJSONField() } }

 static fromJSONField( field: any ): Item { return Item.reified( ).new( { name: decodeFromJSONField(String.reified(), field.name), kinds: decodeFromJSONField(reified.vector(String.reified()), field.kinds), isCosmetic: decodeFromJSONField("bool", field.isCosmetic), colourWay: decodeFromJSONField(String.reified(), field.colourWay), manufacturer: decodeFromJSONField(String.reified(), field.manufacturer), rarity: decodeFromJSONField(String.reified(), field.rarity) } ) }

 static fromJSON( json: Record<string, any> ): Item { if (json.$typeName !== Item.$typeName) { throw new Error("not a WithTwoGenerics json object") };

 return Item.fromJSONField( json, ) }

 static fromSuiParsedData( content: SuiParsedData ): Item { if (content.dataType !== "moveObject") { throw new Error("not an object"); } if (!isItem(content.type)) { throw new Error(`object at ${(content.fields as any).id} is not a Item object`); } return Item.fromFieldsWithTypes( content ); }

 static async fetch( client: SuiClient, id: string ): Promise<Item> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching Item object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isItem(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a Item object`); }
 return Item.fromBcs( fromB64(res.data.bcs.bcsBytes) ); }

 }

/* ============================== GenesisShop =============================== */

export function isGenesisShop(type: string): boolean { type = compressSuiType(type); return type === `${PKG_V1}::genesis_shop::GenesisShop`; }

export interface GenesisShopFields { id: ToField<UID>; items: ToField<Table<ToPhantom<String>, ToPhantom<TableVec<ToPhantom<Item>>>>> }

export type GenesisShopReified = Reified< GenesisShop, GenesisShopFields >;

export class GenesisShop implements StructClass { static readonly $typeName = `${PKG_V1}::genesis_shop::GenesisShop`; static readonly $numTypeParams = 0;

 readonly $typeName = GenesisShop.$typeName;

 readonly $fullTypeName: `${typeof PKG_V1}::genesis_shop::GenesisShop`;

 readonly $typeArgs: [];

 readonly id: ToField<UID>; readonly items: ToField<Table<ToPhantom<String>, ToPhantom<TableVec<ToPhantom<Item>>>>>

 private constructor(typeArgs: [], fields: GenesisShopFields, ) { this.$fullTypeName = composeSuiType( GenesisShop.$typeName, ...typeArgs ) as `${typeof PKG_V1}::genesis_shop::GenesisShop`; this.$typeArgs = typeArgs;

 this.id = fields.id;; this.items = fields.items; }

 static reified( ): GenesisShopReified { return { typeName: GenesisShop.$typeName, fullTypeName: composeSuiType( GenesisShop.$typeName, ...[] ) as `${typeof PKG_V1}::genesis_shop::GenesisShop`, typeArgs: [ ] as [], reifiedTypeArgs: [], fromFields: (fields: Record<string, any>) => GenesisShop.fromFields( fields, ), fromFieldsWithTypes: (item: FieldsWithTypes) => GenesisShop.fromFieldsWithTypes( item, ), fromBcs: (data: Uint8Array) => GenesisShop.fromBcs( data, ), bcs: GenesisShop.bcs, fromJSONField: (field: any) => GenesisShop.fromJSONField( field, ), fromJSON: (json: Record<string, any>) => GenesisShop.fromJSON( json, ), fromSuiParsedData: (content: SuiParsedData) => GenesisShop.fromSuiParsedData( content, ), fetch: async (client: SuiClient, id: string) => GenesisShop.fetch( client, id, ), new: ( fields: GenesisShopFields, ) => { return new GenesisShop( [], fields ) }, kind: "StructClassReified", } }

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

 static async fetch( client: SuiClient, id: string ): Promise<GenesisShop> { const res = await client.getObject({ id, options: { showBcs: true, }, }); if (res.error) { throw new Error(`error fetching GenesisShop object at id ${id}: ${res.error.code}`); } if (res.data?.bcs?.dataType !== "moveObject" || !isGenesisShop(res.data.bcs.type)) { throw new Error(`object at id ${id} is not a GenesisShop object`); }
 return GenesisShop.fromBcs( fromB64(res.data.bcs.bcsBytes) ); }

 }
