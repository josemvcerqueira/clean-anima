#[test_only]
module act::set_up_tests {

    use sui::{
        test_scenario::Scenario
    };
    use act::admin;
    use animalib::access_control::{Admin, AccessControl};

    public fun set_up_admins(scenario: &mut Scenario): (AccessControl, Admin, Admin) {
        admin::init_for_testing(scenario.ctx());

        let sender = scenario.ctx().sender();

        scenario.next_tx(sender);

        let super_admin = scenario.take_from_sender<Admin>();
        let admin = scenario.take_from_sender<Admin>();
        let access_control  = scenario.take_shared<AccessControl>();

        (access_control, super_admin, admin)
    }
}