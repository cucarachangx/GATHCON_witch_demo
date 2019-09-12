using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Drop : MonoBehaviour {

    public bool collectOnFinishLvl = false;
    

    [Space]
    [SerializeField] Vector3 spawnForce = Vector3.zero;
    [SerializeField] Vector3 rndSpawnForceRange = Vector3.zero;
    [SerializeField] float magnetRadio = 5f;
    [SerializeField] float accelerationToAvatar = 1f;
    [SerializeField] float initialFlySpeed = 0.3f;
    [SerializeField] float distanceToGrab = 1f;
      

    bool flyingToAvatar = false;
    Rigidbody rigid = null;
    float flySpeed = 0f;

    // Start is called before the first frame update
    void Start() {
        rigid = GetComponent<Rigidbody>();
        rigid.velocity = CalculateInitialForce();

        if(LevelsController.GetInstance().currenLevel != null && LevelsController.GetInstance().currenLevel.enemies.Count == 0)
            AllEnemiesDead();
        else
            EventDispatcher.AllEnemiesDead += AllEnemiesDead;
    }

    private void OnDestroy() {
        EventDispatcher.AllEnemiesDead -= AllEnemiesDead;
    }

    private void Update() {
        if(!collectOnFinishLvl &&
            Avatar.currentAvatar != null &&
            Vector3.Distance(transform.position, Avatar.currentAvatar.transform.position) <= magnetRadio) {
            FlyToAvatar();
        }

        if(flyingToAvatar)
            UpdateFlyingToAvatar();
    }

    Vector3 CalculateInitialForce() {
        return spawnForce + new Vector3(
            Random.Range(-rndSpawnForceRange.x, rndSpawnForceRange.x),
            Random.Range(-rndSpawnForceRange.y, rndSpawnForceRange.y),
            Random.Range(-rndSpawnForceRange.z, rndSpawnForceRange.z));
    }

    private void OnDrawGizmosSelected() {
        Gizmos.color = Color.blue;
        Gizmos.DrawWireSphere(transform.position, magnetRadio);
    }

    void FlyToAvatar() {
        flyingToAvatar = true;
        GetComponent<Collider>().enabled = false;
        rigid.useGravity = false;
        flySpeed = initialFlySpeed;
    }

    
    void UpdateFlyingToAvatar() {
        if(Avatar.currentAvatar == null) {
            flyingToAvatar = false;
            return;
        }

        flySpeed += accelerationToAvatar * Time.deltaTime;
        rigid.velocity = (Avatar.currentAvatar.transform.position - transform.position).normalized * flySpeed;

        if(Vector3.Distance(Avatar.currentAvatar.transform.position, transform.position) < distanceToGrab) {
            OnGrab(Avatar.currentAvatar);
        }
    }

    protected virtual void OnGrab(Avatar avatar) {
        Destroy(gameObject);
    }

    void AllEnemiesDead() {
        if(collectOnFinishLvl)
            FlyToAvatar();
    }
}
