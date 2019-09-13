using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CoinBag : Singleton<CoinBag> {
    [SerializeField] Text coinsLabel = null;

    int coins = 0;

    public void OnCollectedCoin(int amount) {
        coins += amount;
        coinsLabel.text = coins.ToString();
        coinSource.Play();
        //TODO: ejecutar alguna animacion y sonido cada vez que recibe monedas
    }
}
