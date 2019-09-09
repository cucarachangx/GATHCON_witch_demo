using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LevelGoal : MonoBehaviour
{
    Collider myCollider = null;
    Animator animator = null;

    private void Start() {
        myCollider = GetComponent<Collider>();
        animator = GetComponent<Animator>();
        myCollider.enabled = false;
    }

    public void Open() {
        myCollider.enabled = true;
        animator.SetTrigger("Open");
    }

    private void OnTriggerEnter(Collider other) {
        if(other.GetComponent<Avatar>() != null) {
            LevelsController.GetInstance().currenLevel.AvatarReachesTheGoal();
        }
    }

}
