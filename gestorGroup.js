export default {
  name: "gestionar",
  description: "Gestiona participantes del grupo.",
  alias: ["g", "manage"],
  use: "/gestionar 'add/remove/promote/demote' 'número de WhatsApp'",

  run: async (socket, msg, args) => {
    try {
      const action = args[0];
      const participantNumber = args[1];

      // ID del participante autorizado
      const authorizedParticipantId = "51974312499@s.whatsapp.net";
      const authorId = msg.messages[0].key.participant;

      // Verificar si el autor es el participante autorizado
      if (authorId !== authorizedParticipantId) {
        return socket.sendMessage(msg.messages[0].key.remoteJid, {
          text: "No tienes permiso para usar este comando. Solo el participante autorizado puede gestionar participantes.",
        });
      }

      if (!action || !participantNumber) {
        return socket.sendMessage(msg.messages[0].key.remoteJid, {
          text: "Uso incorrecto. Usa: /gestionar 'add/remove/promote/demote' 'número de WhatsApp'.",
        });
      }

      const validActions = ["add", "remove", "promote", "demote"];
      if (!validActions.includes(action)) {
        return socket.sendMessage(msg.messages[0].key.remoteJid, {
          text: "Acción no válida. Las acciones válidas son: add, remove, promote, demote.",
        });
      }

      const groupId = "51974312499-1605450776@g.us";

      await socket.sendMessage(msg.messages[0]?.key.remoteJid, {
        react: { text: "⏳", key: msg.messages[0]?.key },
      });

      const participantId = `${participantNumber}@s.whatsapp.net`;

      const response = await socket.groupParticipantsUpdate(groupId, [participantId], action);

      await socket.sendMessage(msg.messages[0].key.remoteJid, {
        text: `Operación exitosa: ${action} ${participantId}.`,
      });

      await socket.sendMessage(msg.messages[0]?.key.remoteJid, {
        react: { text: "✅", key: msg.messages[0]?.key },
      });
    } catch (error) {
      console.error("Error al gestionar participantes:", error);

      await socket.sendMessage(msg.messages[0].key.remoteJid, {
        text: "¡Ups! Ocurrió un error inesperado.",
      });

      await socket.sendMessage(msg.messages[0]?.key.remoteJid, {
        react: { text: "❌", key: msg.messages[0]?.key },
      });
    }
  },
};
