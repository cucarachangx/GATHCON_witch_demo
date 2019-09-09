using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class RestartBtn : MonoBehaviour
{
    public void OnClick() {
        SceneManager.LoadScene(SceneManager.GetActiveScene().name);
    }
}
