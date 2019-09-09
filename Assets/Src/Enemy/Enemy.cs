using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Enemy : MonoBehaviour
{
    public float life = 3;
    public bool inmortal = false;


    EnemyWeapon weaponComp = null;
    Animator animator = null;


    // Start is called before the first frame update
    void Start() {
        weaponComp = GetComponent<EnemyWeapon>();
        animator = GetComponent<Animator>();

        if(LevelsController.GetInstance() != null && LevelsController.GetInstance().currenLevel != null) {
            LevelsController.GetInstance().currenLevel.EnemySpawned(this);
        }
    }

    public void ReceiveAvatarBulletImpact(AvatarBullet bullet) {

        if(!inmortal) {
            animator.SetTrigger("TakeDamage");

            life -= bullet.damage;
            if(life <= 0)
                Die();
        }

        //TODO: animacion de hit
    }

    public void Die() {
        animator.SetTrigger("Dead");
        Destroy(gameObject, 1f);

        GetComponent<AvatarWeaponTarget>().enabled = false;
        GetComponent<Collider>().enabled = false;
        weaponComp.enabled = false;

        if(LevelsController.GetInstance() != null && LevelsController.GetInstance().currenLevel != null) {
            LevelsController.GetInstance().currenLevel.EnemyDead(this);
        }
    }
}
