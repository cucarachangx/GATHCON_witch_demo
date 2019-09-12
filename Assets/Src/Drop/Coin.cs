using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Coin : Drop {

    public int coinsCount = 1;

    protected override void OnGrab(Avatar avatar) {
        base.OnGrab(avatar);
        CoinBag.GetInstance().OnCollectedCoin(coinsCount);
    }

}
