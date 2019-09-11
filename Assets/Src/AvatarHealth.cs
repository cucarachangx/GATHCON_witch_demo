﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class AvatarHealth : MonoBehaviour
{
    public Transform healthBar;
    public Slider healthFill;

    public float currentHealth;

    float maxHealth = 100;

    public float healthBarYOffset = 2f;

    private void Start()
    {
        healthBar.position = new Vector3(transform.position.x, transform.position.y + healthBarYOffset, transform.position.z);
        healthFill.value = 1;
    }

    void Update()
    {
        //PositionHealthBar();
        healthBar.LookAt(Camera.main.transform);
    }

    public void ChangeHealth (float amount)
    {
        currentHealth = amount;
        healthFill.value -= currentHealth / maxHealth;
    }

    /*private void PositionHealthBar()
    {
        Vector3 currentPos = transform.position;
        healthBar.position = new Vector3(currentPos.x, currentPos.y + healthBarYOffset, currentPos.z);
        healthBar.LookAt(Camera.main.transform);
    }*/
}
