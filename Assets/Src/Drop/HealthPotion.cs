using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HealthPotion : Drop {

    public int health = 3;

    protected override void OnGrab(Avatar avatar) {
        base.OnGrab(avatar);
        avatar.AddHealth(health);
    }
}