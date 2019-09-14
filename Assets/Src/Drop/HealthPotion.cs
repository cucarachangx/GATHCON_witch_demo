using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HealthPotion : Drop {

    public int health = 3;
    [Space]
    [SerializeField] GameObject onGrabFxPrefab = null;

    protected override void OnGrab(Avatar avatar) {
        base.OnGrab(avatar);
        avatar.AddHealth(health);

        GameObject fx = Instantiate<GameObject>(onGrabFxPrefab, avatar.transform.position, Quaternion.identity);
        Destroy(fx, 1f);
    }
}