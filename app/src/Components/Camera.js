import { useCallback, useEffect, useRef, useState } from "react";
import "./Camera.css";
import { FaCamera } from "react-icons/fa";

export default function Camera({ width = 360, height = 360, setPhoto }) {
  const videoRef = useRef();
  const canvasRef = useRef();
  const [captured, setCaptured] = useState(false);
  const [stream, setStream] = useState(null);

  useEffect(
    () => () => {
      if (stream != null) {
        stream.getTracks().forEach((track) => track.stop());
      }
    },
    [stream]
  );

  const show = useCallback(() => {
    setPhoto(null);
    navigator.mediaDevices
      .getUserMedia({ video: { width, height } })
      .then((stream) => {
        setStream(stream);
        const video = videoRef.current;
        if (video != null) video.srcObject = stream;
      })
      .catch((err) => console.log(err));
  }, [width, height, setPhoto]);

  const capture = useCallback(() => {
    setStream(null);
    const context = canvasRef.current.getContext("2d");
    context.drawImage(videoRef.current, 0, 0, width, height);
    canvasRef.current.toBlob(setPhoto);
  }, [width, height, setPhoto]);

  useEffect(() => {
    captured ? capture() : show();
  }, [videoRef, captured, show, capture]);

  return (
    <div className="camera">
      <div
        className="camera-message"
        style={{
          width: `${height}px`,
          height: `${height}px`,
          "margin-bottom": `${-height-4}px`,
        }}
      >
        <FaCamera id="camera-icon" />
        <div>Camera access required.</div>
      </div>
      <video
        ref={videoRef}
        autoPlay={true}
        onCanPlay={() => videoRef.current.play()}
        width={width}
        height={height}
        className={captured ? "gone" : "visible"}
      ></video>
      <canvas
        ref={canvasRef}
        width={width}
        height={height}
        className={captured ? "visible" : "gone"}
      ></canvas>
      <div className="actions">
        {captured ? (
          <button onClick={() => setCaptured(false)} type="button">
            Retake
          </button>
        ) : (
          <button onClick={() => setCaptured(true)} type="button">
            Capture
          </button>
        )}
      </div>
    </div>
  );
}
