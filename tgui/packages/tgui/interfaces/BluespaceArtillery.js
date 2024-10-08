import { useBackend } from '../backend';
import { Box, Button, LabeledList, NoticeBox, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

export const BluespaceArtillery = (props, context) => {
  const { act, data } = useBackend(context);
  const { notice, connected, unlocked, target, charge, max_charge } = data;
  return (
    <Window width={400} height={280}>
      <Window.Content>
        {!!notice && <NoticeBox>{notice}</NoticeBox>}
        {connected ? (
          <>
            <Section title="Charge">
              <ProgressBar
                ranges={{
                  good: [1, Infinity],
                  average: [0.2, 0.99],
                  bad: [-Infinity, 0.2],
                }}
                value={charge / max_charge}
              />
            </Section>
            <Section
              title="Target"
              buttons={<Button icon="crosshairs" disabled={!unlocked} onClick={() => act('recalibrate')} />}>
              <Box color={target ? 'average' : 'bad'} fontSize="25px">
                {target || 'No Target Set'}
              </Box>
            </Section>
            <Section>
              {unlocked ? (
                <Box style={{ margin: 'auto' }}>
                  <Button
                    fluid
                    content="FIRE"
                    color="bad"
                    disabled={!target}
                    fontSize="30px"
                    textAlign="center"
                    lineHeight="46px"
                    onClick={() => act('fire')}
                  />
                </Box>
              ) : (
                <>
                  <Box color="bad" fontSize="18px">
                    Bluespace artillery is currently locked.
                  </Box>
                  <Box mt={1}>Awaiting authorization via keycard reader from at minimum two station heads.</Box>
                </>
              )}
            </Section>
          </>
        ) : (
          <Section>
            <LabeledList>
              <LabeledList.Item label="Maintenance">
                <Button icon="wrench" content="Complete Deployment" onClick={() => act('build')} />
              </LabeledList.Item>
            </LabeledList>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
