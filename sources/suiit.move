module suiit::example {

    public struct Sword has key, store {
        id: UID,
        magic: u64,
        strength: u64,
    }

    public struct Forge has key {
        id: UID,
        swords_created: u64,
    }

    fun init(ctx: &mut TxContext) {
        let forge = Forge {
          id: object::new(ctx),
          swords_created: 0,
        };
        transfer::transfer(forge, ctx.sender());
    }

    public fun magic(self: &Sword): u64 {
        self.magic
    }

    public fun strength(self: &Sword): u64 {
        self.strength
    }

    public fun swords_created(self: &Forge): u64 {
        self.swords_created
    }

    public fun new_sword(
        forge: &mut Forge,
        magic: u64,
        strength: u64,
        ctx: &mut TxContext,
    ): Sword {
        forge.swords_created = forge.swords_created + 1;
        Sword {
            id: object::new(ctx),
            magic,
            strength,
        }
    }

    public fun sword_create(
        magic: u64,
        strength: u64,
        ctx: &mut TxContext,
    ): Sword {
        Sword {
          id: object::new(ctx),
          magic: magic,
          strength: strength,
        }
    }

    #[test]

    fun test_sword_create_unit() {
        // Create a dummy ctx
        let mut ctx = tx_context::dummy();
        // Create a sword
        let sword = Sword {
            id: object::new(&mut ctx),
            magic: 42,
            strength: 7
        };
        // Check if accessor functions return correct values
        assert!(sword.magic() == 42 && sword.strength() == 7, 1);
        let owner = @0xF001;
        transfer::public_transfer(sword, owner);
    }

    #[test]

    fun test_module_init() {
        use sui::test_scenario;
        // Create test users
        let admin = @0xA001;
        let owner = @0xA002;
        // Init tx
        let mut scenario = test_scenario::begin(admin);
        init(scenario.ctx());
        // Check initial data
        scenario.next_tx(admin);
        let forge = scenario.take_from_sender<Forge>();
        assert!(forge.swords_created() == 0, 1);
        scenario.return_to_sender(forge);
        // Creat sword tx
        scenario.next_tx(admin);
        let mut forge = scenario.take_from_sender<Forge>();
        let sword = forge.new_sword(42, 7, scenario.ctx());
        transfer::public_transfer(sword, owner);
        scenario.return_to_sender(forge);
        // End
        scenario.end();
    }

    #[test]

    fun test_sword_create_integration() {
        use sui::test_scenario;
        // Create test users
        let creator = @0xA001;
        let owner = @0xA002;
        // Creation tx
        let mut scenario = test_scenario::begin(creator);
        let sword = sword_create(42, 7, scenario.ctx());
        transfer::public_transfer(sword, creator);
        // Transfer
        scenario.next_tx(creator);
        let sword = scenario.take_from_sender<Sword>();
        transfer::public_transfer(sword, owner);
        // Validate props (whi is this a tx..?)
        scenario.next_tx(owner);
        let sword = scenario.take_from_sender<Sword>();
        assert!(sword.magic() == 42, 1);
        assert!(sword.strength() == 7, 1);
        scenario.return_to_sender(sword);
        // End
        scenario.end();
    }
}
