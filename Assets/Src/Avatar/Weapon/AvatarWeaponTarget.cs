using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AvatarWeaponTarget : MonoBehaviour
{
	public static List<AvatarWeaponTarget> availableTargets = new List<AvatarWeaponTarget>();


    void OnEnable() {
		availableTargets.Add(this);
	}

	void OnDisable() {
		availableTargets.Remove(this);
	}

	void OnDestroy() {
		availableTargets.Remove(this);
	}

    public bool ReceiveImpact(AvatarBullet bullet) {
        //TODO: pasa el daño
        foreach(var enemyComp in GetComponents<Enemy>()) {
            enemyComp.ReceiveAvatarBulletImpact(bullet);
        }
        return true;
	}
}
