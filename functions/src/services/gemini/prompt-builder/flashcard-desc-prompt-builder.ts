const DEFAULT_DESCRIPTION_INSTRUCTION =
  'For each flashcard, generate a concise example (1–2 sentences) that shows how the term or concept is used in a realistic context. ' +
  'Focus on practical usage that reinforces understanding of the "front" term. ' +
  'Do not repeat the definition from the "back" field — illustrate it instead.';

/**
 * Returns the description-rules section to embed in the flashcard prompt.
 * When a custom rule is provided it is used exclusively; the default is omitted.
 */
export const buildFlashcardDescriptionRulesSection = (descriptionRules?: string): string => {
  const hasCustomRules = !!descriptionRules?.trim();

  const instruction = hasCustomRules ? descriptionRules!.trim() : DEFAULT_DESCRIPTION_INSTRUCTION;

  return `\nDESCRIPTION GENERATION RULES:
---
${instruction}
---\n`;
};
