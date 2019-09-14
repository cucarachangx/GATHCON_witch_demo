using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Coin : Drop {

    public int coinsCount = 1;
    [Space]
    [SerializeField] GameObject onGrabFxPrefab = null;

    protected override void OnGrab(Avatar avatar) {
        base.OnGrab(avatar);
        CoinBag.GetInstance().OnCollectedCoin(coinsCount);

        GameObject fx = Instantiate<GameObject>(onGrabFxPrefab, avatar.transform.position, Quaternion.identity);
        Destroy(fx, 1f);
    }

}
