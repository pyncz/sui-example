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

    fun init(ctx: &mut sui::tx_context::TxContext) {
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
}
