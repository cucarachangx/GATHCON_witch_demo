using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;

public class StickAvatarInput : MonoBehaviour, IAvatarInput,
    IPointerDownHandler, IPointerUpHandler, IDragHandler
{
    public bool stickAlwaysVisible = false;//TODO: implementar
    public float maxRadio = 100;

    [Space]
    [SerializeField] RectTransform stickRoot = null;
    [SerializeField] RectTransform stick = null;

    bool inUse = false;
    int currPointerId = int.MinValue;
    CanvasGroup stickCanvasGroup = null;
    CanvasScaler canvasScaler = null;
    Canvas canvas = null;

    Vector2 inputAxis = Vector2.zero;

    // Start is called before the first frame update
    void Start() {
        stickCanvasGroup = stickRoot.GetComponent<CanvasGroup>();
        canvasScaler = GetComponentInParent<CanvasScaler>();
        canvas = GetComponentInParent<Canvas>();
        stickCanvasGroup.alpha = 0f;
    }

    void IPointerDownHandler.OnPointerDown(PointerEventData eventData) {
        if(!inUse)
            StartDrag(eventData);
    }

    void IPointerUpHandler.OnPointerUp(PointerEventData eventData) {
        if(inUse && currPointerId == eventData.pointerId) {
            EndDrag(eventData);
        }
    }

    void IDragHandler.OnDrag(PointerEventData eventData) {
        if(!inUse || eventData.pointerId != currPointerId) return;

        Vector2 pos = Vector2.zero;
        RectTransformUtility.ScreenPointToLocalPointInRectangle(
            stickRoot,
            eventData.position,
            canvas.worldCamera,
            out pos);

        pos = Vector2.ClampMagnitude(pos, maxRadio);
        inputAxis = pos / maxRadio;
        stick.localPosition = pos;
    }

    void StartDrag(PointerEventData eventData) {
        inUse = true;
        inputAxis = Vector2.zero;
        stickCanvasGroup.alpha = 1f;
        currPointerId = eventData.pointerId;
        stick.localPosition = Vector2.zero;

        Vector2 pos = Vector2.zero;
        RectTransformUtility.ScreenPointToLocalPointInRectangle(
            transform as RectTransform,
            eventData.position,
            canvas.worldCamera,
            out pos);

        stickRoot.localPosition = pos;
    }

    void EndDrag(PointerEventData eventData) {
        inUse = false;
        inputAxis = Vector2.zero;
        stickCanvasGroup.alpha = 0f;
        currPointerId = int.MinValue;

    }

    public Vector2 GetInput() {
        return inputAxis;
    }
}
