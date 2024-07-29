import { client, getId } from './utils.js';

(async () => {

    const { data }: any = await client.getObject({
        id: getId("genesis_shop::GenesisShop"),
        options: { showContent: true }
    });

    let equipmentsTableVecId = data.content.fields.items.fields.id.id;

    const equipmentsTableVec = await client.getDynamicFields({
        parentId: equipmentsTableVecId,
    });
    
    // one equipment among the 18 
    const equipmentId = equipmentsTableVec.data[0].objectId;
    
    const equipment: any = await client.getObject({
        id: equipmentId,
        options: { showContent: true }
    });

    // e.g. Chestpiece
    const equipmentName = equipment.data.content.fields.name;

    const itemsTableId = equipment.data.content.fields.value.fields.contents.fields.id.id;

    const itemsTable = await client.getDynamicFields({
        parentId: itemsTableId,
    });

    // one item among the 3k variations (use pagination to retrieve all)
    const itemId = itemsTable.data[0].objectId;

    const item: any = await client.getObject({
        id: itemId,
        options: { showContent: true }
    });

    const itemFields = item.data.content.fields.value.fields;

    console.log(itemFields);
})()